@tool
@icon("res://addons/godotlytoria/textures/Instance.svg")
## Instance is the base class of all classes. 
## Every class derives from it and has all properties, 
## events and functions Instance has.
class_name PolyInstance 
extends Node3D
#var __properties

## The name given to the object in Polytoria
@export var Name: String = "Instance"
#@export var ClassName = "Instance"

signal ChildAdded(child)
signal ChildRemoved(child)
signal Clicked(player)
signal MouseEnter
signal MouseExit
signal Touched(otherPart)
signal TouchEnded(otherPart)

func get_properties() -> Array[Dictionary]:
	return get_script().get_script_property_list()

func _enter_tree() -> void:
	if Name == null: Name = name
