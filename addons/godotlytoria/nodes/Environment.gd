@tool
@icon("res://addons/godotlytoria/textures/icons/Environment.svg")
extends PolyInstance
## Environment is the primary object intended for storing active objects in the place.
##
##[color=khaki]This object cannot be created by scripts using Instance.New().[br]
##[color=medium_purple]This object is automatically created by Polytoria. Additionally, scripts cannot change its parent.[br]
##[/color]
class_name PolyEnvironment

# TODO: Add all the skyboxes 
var worldEnvironment: WorldEnvironment = WorldEnvironment.new()

@export var AutoGenerateNavMesh: bool
@export var FogColor: Color
@export var FogEnabled: bool
@export var FogStartDistance: float
@export var FogEndDistance: float
@export var Gravity: Vector3 = Vector3(0,-75,0)
@export var PartDestroyHeight: float
@export var Skybox: Polytoria.SkyboxPreset

## Creates a deadly explosion killing players and applying force to parts at the given position.
## Example:
## [codeblock]game["Environment"]:CreateExplosion(Vector3.New(0, 0, 0), 30, 5000, false, nil, 10)[/codeblock]
func CreateExplosion(): pass
func OverlapBox() -> Array[PolyInstance]: return []
func OverlapSphere() -> Array[PolyInstance]: return []

func _enter_tree() -> void:
	if worldEnvironment == null:
		worldEnvironment = WorldEnvironment.new()
	worldEnvironment.environment = load("res://addons/godotlytoria/skyboxes/day1.tres")
	add_child(worldEnvironment)

func _exit_tree() -> void:
	remove_child(worldEnvironment)
