@tool
@icon("res://addons/godotlytoria/textures/Player.svg")
extends PolyDynamicInstance
class_name PolyPlayer

@export var Anchored : bool = false 
@export var CanMove : bool = true 
@export var ChatColor : Color = Color(255,255,255) 
@export var ShirtID : int 
@export var PantsID : int 
@export var FaceID : int 
@export var HeadColor :  Color 
@export var Health : float = 100 
@export var IsAdmin : bool 
@export var IsCreator : bool 
@export var IsInputFocused : bool 
@export var JumpPower : float = 36 
@export var LeftArmColor :  Color 
@export var LeftLegColor :  Color 
@export var MaxHealth : float = 100 
@export var MaxStamina : float = 3 
@export var RespawnTime : float = 5 
@export var RightArmColor :  Color 
@export var RightLegColor :  Color 
@export var SittingIn : PolySeat 
@export var SprintSpeed : float = 25 
@export var Stamina : float = 0 
@export var StaminaEnabled : bool = true 
@export var StaminaRegen : float = 1.2 
@export var TorsoColor :  Color 
@export var UserID : int 
@export var WalkSpeed : float = 16 
