@tool
@icon("res://addons/godotlytoria/textures/icons/Decal.svg")
extends PolyDynamicInstance
## Decals are objects that can have an image texture and are placed in the world.
class_name PolyDecal

# TODO: Add Godot functionality.

## Determines the color of the decal.
@export var _Color:  Color 
## The type of image to be used.
@export var ImageType: Polytoria.ImageType 
## Specifies the image asset ID of the decal.
@export var ImageID: int 
## The offset of the texture on the decal.
@export var TextureOffset:  Vector2 
## The scale of the texture on the decal.
@export var TextureScale:  Vector2 
## Determines whether or not the decal should cast shadows.
@export var CastShadows: bool 
