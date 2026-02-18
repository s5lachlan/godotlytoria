@tool
@icon("res://addons/godotlytoria/textures/icons/Text3D.svg")
extends PolyDynamicInstance
class_name PolyText3D

var label3D : Label3D = Label3D.new()

## Specifies the text to display.
@export var Text: String:
	set(value):
		Text = value
		label3D.text = value
## Specifies the color of the text.
@export var _Color: Color = Color.WHITE_SMOKE:
	set(value):
		_Color = value
		label3D.modulate = value
	get():
		return _Color
## Determines whether or not the text should be facing the camera or not.
@export var FaceCamera: bool:
	set(value):
		FaceCamera = value
		label3D.billboard = BaseMaterial3D.BILLBOARD_ENABLED if value else BaseMaterial3D.BILLBOARD_DISABLED
## Specifies the font of the text (using the TextFontPreset enum)
@export var _Font: Polytoria.TextFontPreset:
	set(value):
		_Font = value
		label3D.font = Polytoria.get_font(_Font)
## Specifies the size of the font.
@export var FontSize: float = 36:
	set(value):
		FontSize = value
		label3D.font_size = value
# TODO: fix this its bugged vert alignemnt was 512 for some reason
## Specifies the horizontal alignment of the text.
@export var _HorizontalAlignment: HorizontalAlignment:
	set(value):
		_HorizontalAlignment = value
		#label3D.horizontal_alignment = value
# TODO: fix this its bugged vert alignemnt was 512 for some reason
## Specifies the vertical alignment of the text.
@export var _VerticalAlignment: VerticalAlignment:
	set(value):
		_VerticalAlignment = value
		#label3D.vertical_alignment = value

func _enter_tree() -> void:
	if label3D == null:
		label3D = label3D.new()
	label3D.pixel_size = 0.05
	label3D.text = Text
	label3D.modulate = _Color
	label3D.outline_size = 0
	label3D.font = Polytoria.get_font(_Font)
	label3D.font_size = FontSize
	#label3D.horizontal_alignment = _HorizontalAlignment
	#label3D.vertical_alignment = _VerticalAlignment
	label3D.billboard = BaseMaterial3D.BILLBOARD_ENABLED if FaceCamera else BaseMaterial3D.BILLBOARD_DISABLED
	add_child(label3D)
	label3D.owner = self
	
func _exit_tree() -> void:
	remove_child(label3D)
