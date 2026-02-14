@tool
@icon("res://addons/godotlytoria/textures/PointLight.svg")
extends PolyDynamicInstance
class_name PolySunLight

## The color of the sun light.
@export var _Color: Color
## The brightness of the sun light.
@export var Brightness: float
## Whether the sun light casts shadows.
@export var Shadows: bool
