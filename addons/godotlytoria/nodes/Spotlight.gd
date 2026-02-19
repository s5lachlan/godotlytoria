@tool
@icon("res://addons/godotlytoria/textures/icons/SpotLight.svg")
extends PolyDynamicInstance
class_name PolySpotlight

var spotLight: SpotLight3D = SpotLight3D.new()

@export var Angle: float:
	set(value):
		Angle = value
		spotLight.spot_angle = value
@export var Brightness: float = 0.75:
	set(value):
		Brightness = value
		spotLight.light_energy = value
@export var _Color: Color = Color.WHITE:
	set(value):
		_Color = value
		spotLight.light_color = value
@export var _Range: float = 60:
	set(value):
		_Range = value 
		spotLight.spot_range = value
@export var Shadows: bool = true:
	set(value):
		Shadows = value
		spotLight.shadow_enabled = value

func _enter_tree() -> void:
	if spotLight == null:
		spotLight = SpotLight3D.new()
	spotLight.spot_range = _Range
	spotLight.spot_angle = Angle
	spotLight.shadow_enabled = Shadows
	spotLight.light_color = _Color
	spotLight.light_energy = Brightness
	add_child(spotLight)
	
func _exit_tree() -> void:
	remove_child(spotLight)
