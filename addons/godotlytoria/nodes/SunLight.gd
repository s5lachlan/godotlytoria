@tool
@icon("res://addons/godotlytoria/textures/icons/PointLight.svg")
extends PolyDynamicInstance
class_name PolySunLight

var directionalLight3D: DirectionalLight3D = DirectionalLight3D.new()

## The color of the sun light.
@export var _Color: Color:
	set(value):
		_Color = value
		directionalLight3D.light_color = value
## The brightness of the sun light.
@export var Brightness: float:
	set(value):
		Brightness = value
		directionalLight3D.light_energy = value
## Whether the sun light casts shadows.
@export var Shadows: bool:
	set(value):
		Shadows = value
		directionalLight3D.shadow_enabled = value

func  _enter_tree() -> void:
	if directionalLight3D == null:
		directionalLight3D = DirectionalLight3D.new()
	directionalLight3D.shadow_enabled = Shadows
	directionalLight3D.light_color = _Color
	directionalLight3D.light_energy = Brightness
	add_child(directionalLight3D)
	
func _exit_tree() -> void:
	remove_child(directionalLight3D)
