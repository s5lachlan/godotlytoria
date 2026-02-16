@tool

extends EditorNode3DGizmoPlugin

func _has_gizmo(node):
	return node is PolyPart

func _get_gizmo_name():
	return "SampleCube"

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

func _set_handle(gizmo: EditorNode3DGizmo, handle_id: int, secondary: bool, camera: Camera3D, screen_pos: Vector2):
	var n = gizmo.get_node_3d()
	
	var plane : Plane;
	match handle_id:
		0: plane = Plane.PLANE_XY
		1: plane = Plane.PLANE_XY
		2: plane = Plane.PLANE_YZ
		3: plane = Plane.PLANE_XY
		4: plane = Plane.PLANE_YZ
		5: plane = Plane.PLANE_XY
	plane = n.global_transform * plane
	
	var ray_from = camera.project_ray_origin(screen_pos)
	var ray_to = camera.project_ray_normal(screen_pos)
	var intersection = plane.intersects_ray(ray_from, ray_to)
	var drag_to = n.global_transform.affine_inverse()
	if intersection != null:
		drag_to *= intersection
	var last_scale = n.scale
	match handle_id:
		0: 
			n.scale.x *= drag_to.x + 0.5
		1: 
			n.scale.y *= drag_to.y + 0.5
		2: 
			n.scale.z *= drag_to.z + 0.5
		3: 
			n.scale.x *= drag_to.x - 0.5
		4: 
			n.scale.z *= drag_to.z - 0.5
		5: 
			n.scale.y *= drag_to.y - 0.5
	n.scale = abs(n.scale)
	match handle_id:
		0:
			n.position -= (last_scale - n.scale) * 0.5
		1:
			n.position -= (last_scale - n.scale) * 0.5
		2:
			n.position -= (last_scale - n.scale) * 0.5
		3:
			n.position += (last_scale - n.scale) * 0.5
		4:
			n.position += (last_scale - n.scale) * 0.5
		5:
			n.position += (last_scale - n.scale) * 0.5
	n.update_gizmos()
