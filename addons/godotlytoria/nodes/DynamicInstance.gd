@tool
@icon("res://addons/godotlytoria/textures/icons/DynamicInstance.svg")
extends PolyInstance
class_name PolyDynamicInstance

# Polytoria scaling is position -= (scale - value) * 0.5

@export_group("Local")
## Specifies the position relative to the parent of an instance.
@export var LocalPosition : Vector3 = Vector3(0, 10, 0):
	get = _get_local_position,
	set = _set_local_position
## Specifies the rotation relative to the parent of an instance.
@export var LocalRotation : Vector3 = Vector3(0, 0, 0):
	get = _get_local_rotation,
	set = _set_local_rotation
## The size of the instance relative to its parent.
@export var LocalSize : Vector3 = Vector3(1, 1, 1):
	get = _get_local_my_size,
	set = _set_local_my_size
@export_group("Global")
## Specifies the position of an instance.
@export var Position : Vector3 :
	get = _get_position,
	set = _set_position
## Specifies the rotation of an instance.
#@export var Rotation : Vector3 = Vector3(0, 0, 0) :
	#get = _get_rotation,
	#set = _set_rotation
## Specifies the size of an instance.
@export var Size : Vector3 = Vector3(1, 1, 1) :
	get = _get_my_size,
	set = _set_my_size

func _set_position(value):
	if !is_inside_tree(): return
	var godot_value = Vector3(value.x, value.y, -value.z)
	global_position = godot_value
	
func _set_my_size(value : Vector3):
	if !is_inside_tree(): return
	var godot_value = Vector3(value.x, value.y, value.z)
	var new_basis = Basis.from_scale(godot_value)
	global_basis = new_basis
	
func _set_rotation(value):
	if !is_inside_tree(): return
	var godot_value = Vector3(-value.x, -value.y, value.z)
	global_rotation_degrees = godot_value
	
func _set_local_rotation(value):
	var godot_value = Vector3(-value.x, -value.y, value.z)
	rotation_degrees = godot_value
	
func _set_local_my_size(value : Vector3):
	var godot_value = Vector3(value.x, value.y, value.z)
	scale = godot_value
	
func _set_local_position(value):
	var godot_value = Vector3(value.x, value.y, -value.z)
	position = godot_value

func _get_local_position():
	var unity_value = Vector3(position.x, position.y, -position.z)
	return unity_value
	
func _get_local_rotation():
	var unity_value = Vector3(-rotation_degrees.x, -rotation_degrees.y, rotation_degrees.z)
	return unity_value
	
func _get_local_my_size() -> Vector3:
	var unity_value = Vector3(scale.x, scale.y, scale.z)
	return unity_value
	
func _get_position():
	if !is_inside_tree(): return
	var unity_value = Vector3(global_position.x, global_position.y, -global_position.z)
	return unity_value
	
func _get_my_size():
	if !is_inside_tree(): return
	#var unity_value = Vector3(scale.x, scale.y, scale.z)
	#global_basis.get_scale()
	var unity_value = Vector3(global_basis.get_scale().x, global_basis.get_scale().y, global_basis.get_scale().z)
	return unity_value
	
func _get_rotation():
	#if !is_inside_tree(): return
	var unity_value = Vector3(-global_rotation_degrees.x, -global_rotation_degrees.y, global_rotation_degrees.z)
	return unity_value
