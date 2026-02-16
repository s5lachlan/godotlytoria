@tool

extends EditorNode3DGizmoPlugin
var undo_redo: EditorUndoRedoManager

func _has_gizmo(node):
	return node is PolyPart

func _get_gizmo_name():
	return "Stretch"

func _init():
	create_material("main", Color(1.0, 1.0, 1.0, 1.0))
	create_handle_material("handles")

func _redraw(gizmo):
	gizmo.clear()
	var n = gizmo.get_node_3d()
	
	var handles = PackedVector3Array()
	handles.push_back(Vector3(0.5, 0, 0)) # x-handle, handle_id 0
	handles.push_back(Vector3(0, 0.5, 0)) # y-handle, handle_id 1
	handles.push_back(Vector3(0, 0, 0.5)) # z-handle, handle_id 2
	handles.push_back(Vector3(-0.5, 0, 0)) # -x-handle, handle_id 3
	handles.push_back(Vector3(0, 0, -0.5)) # -z-handle, handle_id 4
	handles.push_back(Vector3(0, -0.5, 0)) # y-handle, handle_id 5
	gizmo.add_handles(handles, get_material("handles", gizmo), [])

func _get_handle_name(gizmo, handle_id, secondary):
	match handle_id:
		0: return "x"
		1: return "y"
		2: return "z"
		3: return "-x"
		4: return "-z"
		5: return "-y"

func _get_handle_value(gizmo, handle_id, secondary):
	var n = gizmo.get_node_3d()
	match handle_id:
		0: return n.scale.x
		1: return n.scale.y
		2: return n.scale.z
		3: return -n.scale.x
		4: return -n.scale.z
		5: return -n.scale.y

var global_restore = {}

func _begin_handle_action(gizmo: EditorNode3DGizmo, handle_id: int, secondary: bool):
	var n = gizmo.get_node_3d()
	var state = {
		"scale": n.scale,
		"position": n.position
	}
	global_restore = state

func _commit_handle(gizmo: EditorNode3DGizmo, handle_id: int, secondary: bool, restore: Variant, cancel: bool):
	var node = gizmo.get_node_3d()
	if cancel:
		node.scale = global_restore.scale
		node.position = global_restore.position
		node.update_gizmos()
		return
	
	# Start undo action
	undo_redo.create_action("Stretch %s (Godotlytoria)" % _get_handle_name(gizmo, handle_id, secondary))
	# Revert to global_restore
	undo_redo.add_undo_property(node, "scale", global_restore.scale)
	undo_redo.add_undo_property(node, "position", global_restore.position)
	# Set final
	undo_redo.add_do_property(node, "scale", node.scale)
	undo_redo.add_do_property(node, "position", node.position)
	# Set redo
	undo_redo.add_do_method(node, "update_gizmos")
	undo_redo.add_undo_method(node, "update_gizmos")
	
	undo_redo.commit_action()

func _set_handle(gizmo: EditorNode3DGizmo, handle_id: int, secondary: bool, camera: Camera3D, screen_pos: Vector2):
	# Get node and set last scale
	var n = gizmo.get_node_3d()
	var last_scale = n.scale
	
	# Create a plane for transformations
	var plane: Plane
	match handle_id:
		0, 1, 3, 5: 
			plane = Plane.PLANE_XY
		2, 4: 
			plane = Plane.PLANE_YZ
	plane = n.global_transform * plane
	
	# Raycast from screen to find intersection in world space
	var ray_from = camera.project_ray_origin(screen_pos)
	var ray_to = camera.project_ray_normal(screen_pos)
	var intersection = plane.intersects_ray(ray_from, ray_to)
	
	# Convert intersection back to local space for scale calculation
	var drag_to = n.global_transform.affine_inverse()
	if intersection != null:
		drag_to *= intersection
	
	match handle_id:
		0: n.scale.x *= drag_to.x + 0.5
		1: n.scale.y *= drag_to.y + 0.5
		2: n.scale.z *= drag_to.z + 0.5
		3: n.scale.x *= drag_to.x - 0.5
		4: n.scale.z *= drag_to.z - 0.5
		5: n.scale.y *= drag_to.y - 0.5
	
	# Force positive scale to prevent negative values.
	n.scale = n.scale.abs()
	
	# Set position compensation
	var delta_pos = Vector3.ZERO
	match handle_id:
		0:  
			var delta = (n.scale.x - last_scale.x) * 0.5
			delta_pos = delta * (n.transform.basis.x / n.scale.x)
		1:  
			var delta = (n.scale.y - last_scale.y) * 0.5
			delta_pos = delta * (n.transform.basis.y / n.scale.y)
		2:  
			var delta = (n.scale.z - last_scale.z) * 0.5
			delta_pos = delta * (n.transform.basis.z / n.scale.z)
		3:  
			var delta = (last_scale.x - n.scale.x) * 0.5
			delta_pos = delta * (n.transform.basis.x / n.scale.x)
		4:  
			var delta = (last_scale.z - n.scale.z) * 0.5
			delta_pos = delta * (n.transform.basis.z / n.scale.z)
		5:  
			var delta = (last_scale.y - n.scale.y) * 0.5
			delta_pos = delta * (n.transform.basis.y / n.scale.y)
	
	# Apply and refresh
	n.position += delta_pos
	n.update_gizmos()
