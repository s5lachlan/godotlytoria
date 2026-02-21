@tool
@icon("res://addons/godotlytoria/textures/icons/UITextInput.svg")
extends PolyUIView
class_name PolyUITextInput

# TODO: Add Godot functionality

## Whether the text should be automatically sized to fit the label's size.
@export var AutoSize: bool 
## The font of the label.
@export var _Font:  Polytoria.TextFontPreset 
## The font size of the label.
@export var FontSize: float 
## Set if the text input can be multiline.
@export var IsMultiline: bool 
## Set if the text input can be edited or not.
@export var IsReadOnly: bool 
## Determines how the text is justified.
@export var JustifyText:  Polytoria.TextJustify 
## The maximum font size of the UI element if AutoSize is set to true.
@export var MaxFontSize: float 
## The placeholder of the text input.
@export var Placeholder: String 
## The color of the placeholder text.
@export var PlaceholderColor:  Color 
## The text of the label.
@export var Text: String 
## The color of the text.
@export var TextColor:  Color 
## The vertical alignment of the text.
@export var VerticalAlign: Polytoria.TextVerticalAlign
