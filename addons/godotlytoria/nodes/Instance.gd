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

func set_default_name():
	if Name == null or Name == "": 
		Name = get_script().get_global_name()
