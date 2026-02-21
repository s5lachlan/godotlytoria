@tool
@icon("res://addons/godotlytoria/textures/icons/UIField.svg")

extends PolyInstance
class_name PolyUIField

# TODO: Add Godot functionality.

## The pivot point of the UI element.
@export var PivotPoint :Vector2 = Vector2(0.5, 0.5)
## The offset of the UI element in pixels.
@export var PositionOffset: Vector2 = Vector2(100, 100)
## The position of the UI element relative to its parent.
@export var PositionRelative: Vector2 = Vector2(0.5, 0.5)
## The rotation of the UI element.
@export var Rotation: float
## The size of the UI element in pixels.
@export var SizeOffset: Vector2 = Vector2(100, 100)
## The size of the UI element relative to its parent.
@export var SizeRelative: Vector2 = Vector2(1, 1)
## Determines whether the UI element is visible or not.
@export var Visible: bool = true
## Determines whether the UI element clips its descendants.
@export var ClipDescendants: bool
