@tool
@icon("res://addons/godotlytoria/textures/icons/Part.svg")
extends PolyDynamicInstance
class_name PolyPart

var mesh_instance = MeshInstance3D.new()
var material = StandardMaterial3D.new()
@export_group("Visual")
## Specifies the color of a part.
@export var _Color : Color = Color.WHITE :
	set(value):
		_Color = value
		material.albedo_color = value
		mesh_instance.transparency = 1 - value.a
	get():
		return _Color
## Specifies the material of the part.
@export var _Material : Polytoria.PartMaterial :
	set(value):
		_Material = value
		set_material()
## Specifies the shape of a part.
@export var Shape : Polytoria.PartShape :
	set(value):
		Shape = value
		set_shape()
## Determines whether to display studs on the part or not.
@export var HideStuds = false
## Specifies whether the part casts its shadow on other parts.
@export var CastShadows = true
@export_group("Physics")
## Specifies whether the part is to be affected by physics or not.
@export var Anchored = true
## Specifies whether the part can be collided with or not.
@export var CanCollide = true
## Determines whether this part is affected by gravity or not.
@export var UseGravity = true
## Angular drag (air resistance) of this part.
@export var AngularDrag : float
## Specifies the angular velocity of a part.
@export var AngularVelocity : Vector3
## Specifies the velocity of a part.
@export var Velocity : Vector3
## Determines how bouncy the part is when players land on it.
@export var Bounciness : float
## Determines Drag (air resistance) of this part.
@export var Drag : float
## Determines the amount of friction between the part and players on it.
@export var Friction : float = 0.6
## Specifies the mass of a part in kilograms.
@export var Mass : float
@export_group("Gameplay")
## Specifies whether the part can be used as a spawn location or not.
@export var IsSpawn = false

func _enter_tree() -> void:
	for n in get_children():
		n.queue_free()
	set_shape()
	mesh_instance.name = "GeneratedMesh"
	add_child(mesh_instance)
	set_material()
	mesh_instance.owner = self
	mesh_instance.visible = true

func set_material():
	if mesh_instance.mesh == null:
		return
	if mesh_instance.material_override == null:
		material = StandardMaterial3D.new()
		mesh_instance.material_override = material
	material.roughness = 1.0
	material.albedo_color = _Color
	material.albedo_texture = Polytoria.get_material(_Material)
	mesh_instance.transparency = 1 - _Color.a
	material.uv1_scale = Vector3(0.5,0.5,0.5)
	material.uv1_triplanar = true
	material.uv1_world_triplanar = true

func set_shape():
	mesh_instance.mesh = Polytoria.get_part_shape(Shape)

func _exit_tree() -> void:
	set_notify_transform(false)
	remove_child(mesh_instance)
