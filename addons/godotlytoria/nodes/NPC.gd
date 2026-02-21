@tool
@icon("res://addons/godotlytoria/textures/icons/NPC.svg")
extends PolyDynamicInstance
class_name PolyNPC

@export var Anchored: bool 
@export var HeadColor:  Color 
@export var TorsoColor:  Color 
@export var LeftArmColor:  Color 
@export var RightArmColor:  Color 
@export var LeftLegColor:  Color 
@export var RightLegColor:  Color 

@export var FaceID: int 
@export var ShirtID: int 
@export var PantsID: int 
@export var Health: float 
@export var MaxHealth: float = 100 
@export var WalkSpeed: float 
@export var JumpPower: float 

@export var Velocity: Vector3
