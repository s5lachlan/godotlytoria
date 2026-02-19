@tool
@icon("res://addons/godotlytoria/textures/icons/PointLight.svg")
extends PolyDynamicInstance
class_name PolyPointLight

var pointLight: OmniLight3D = OmniLight3D.new()

@export var Brightness: float = 0.75:
	set(value):
		Brightness = value
		pointLight.light_energy = value
@export var _Color: Color = Color.WHITE:
	set(value):
		_Color = value
		pointLight.light_color = value
@export var _Range: float = 60:
	set(value):
		_Range = value 
		pointLight.omni_range = value
@export var Shadows: bool = true:
	set(value):
		Shadows = value
		pointLight.shadow_enabled = value

func _enter_tree() -> void:
	if pointLight == null:
		pointLight = OmniLight3D.new()
	pointLight.omni_range = _Range
	pointLight.shadow_enabled = Shadows
	pointLight.light_color = _Color
	pointLight.light_energy = Brightness
	add_child(pointLight)
	
func _exit_tree() -> void:
	remove_child(pointLight)
