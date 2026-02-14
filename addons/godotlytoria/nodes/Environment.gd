@tool
@icon("res://addons/godotlytoria/textures/Environment.svg")
extends PolyInstance
class_name PolyEnvironment

@export var AutoGenerateNavMesh: bool
@export var FogColor: Color
@export var FogEnabled: bool
@export var FogStartDistance: float
@export var FogEndDistance: float
@export var Gravity: Vector3 = Vector3(0,-75,0)
@export var PartDestroyHeight: float
@export var Skybox: Polytoria.SkyboxPreset
