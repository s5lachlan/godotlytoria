@tool
@icon("res://addons/godotlytoria/textures/icons/UIImage.svg")
extends PolyUIField
class_name PolyUIImage

# TODO: Add Godot functionality.

## Specifies the color of the image.
@export var _Color: Color
## Specifies the image ID of the UIImage.
@export var ImageID: String
## Type of Image
@export var ImageType: Polytoria.ImageType
## Returns whether or not the image is loading.
var Loading: bool
## Determines whether the image is clickable.
@export var Clickable: bool
