@tool
@icon("res://addons/godotlytoria/textures/BaseScript.svg")
extends PolyInstance
class_name PolyBaseScript

## Setting this to a path, e.g res://scripts/example.lua will substitute the source script for the file you chose.
@export_file("*.lua") var ScriptPath = ""

## As of right now this is not ideal, about the most basic thing I suppose.
@export_multiline var Source = ""

func _enter_tree() -> void:
	set_script_from_path()

func _notification(what: int) -> void:
	if what == NOTIFICATION_EDITOR_PRE_SAVE:
		set_script_from_path()

func set_script_from_path():
	if ScriptPath != "" and ScriptPath != null and FileAccess.file_exists(ScriptPath):
		Source = FileAccess.get_file_as_string(ScriptPath)
	pass
