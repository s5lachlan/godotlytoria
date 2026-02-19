@tool
@icon("res://addons/godotlytoria/textures/icons/Instance.svg")
## Instance is the base class of all classes. 
## Every class derives from it and has all properties, 
## events and functions Instance has.
class_name PolyInstance 
extends Node3D

## The name given to the object in Polytoria
@export var Name: String = ""
## Seems to not be required by editor.
#@export var ClassName = "Instance"

func get_properties() -> Array[Dictionary]:
	return get_script().get_script_property_list()

var entered = false

func _notification(what: int) -> void:
	if what == NOTIFICATION_PATH_RENAMED and entered:
		Name = name
	if what == NOTIFICATION_ENTER_WORLD:
		set_default_name()
		entered = true
	if what == NOTIFICATION_EXIT_WORLD:
		entered = false
	if what == NOTIFICATION_PARENTED and get_script().get_global_name().trim_prefix("Poly") in Polytoria.RootNodes:
		if get_parent().name != "Game":
			push_error("[Polytoria] Godotlytoria has detected that you may have moved an essential root node, named: ",
		name, " and reparented it to something else. If this node is not a child of \"Game\" then your place will not load.")
		

func set_default_name():
	if Name == null or Name == "": 
		Name = get_script().get_global_name()
