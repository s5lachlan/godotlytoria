@tool
@icon("res://addons/godotlytoria/textures/Instance.svg")
## Instance is the base class of all classes. 
## Every class derives from it and has all properties, 
## events and functions Instance has.
class_name PolyInstance 
extends Node3D

## The name given to the object in Polytoria
@export var Name: String = "Instance"
## Seems to not be required by editor.
#@export var ClassName = "Instance"

func get_properties() -> Array[Dictionary]:
	return get_script().get_script_property_list()

func _enter_tree() -> void:
	if Name == null: Name = name
