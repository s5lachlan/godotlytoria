@tool
@icon("res://addons/godotlytoria/textures/icons/UILabel.svg")
extends PolyUIView
class_name PolyUILabel

## Whether the text should be automatically sized to fit the label's size.
@export var AutoSize : bool
## The font of the label.
@export var _Font: Polytoria.TextFontPreset
## The font size of the label.
@export var FontSize : float
## Determines how the text is justified.
@export var JustifyText: Polytoria.TextJustify
## The maximum font size of the UI element if AutoSize is set to true.
@export var MaxFontSize: float
## The text of the label.
@export var Text: String
## The color of the text.
@export var TextColor: Color
## The vertical alignment of the text.
@export var VerticalAlign: Polytoria.TextVerticalAlign
