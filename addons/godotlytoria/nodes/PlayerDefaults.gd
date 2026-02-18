@tool
@icon("res://addons/godotlytoria/textures/icons/PlayerDefaults.svg")
extends PolyInstance
class_name PolyPlayerDefaults

## Determines the default color of players' usernames in chat.
@export var ChatColor : Color = Color(255,255,255)
## Determines how high the player jumps by default.
@export var JumpPower : float = 36
## Determines the default maximum health of players.
@export var MaxHealth : float = 100
## Determines the default maximum stamina of players.
@export var MaxStamina : float = 3
## Determines the default of how long it takes between player's death and respawn.
@export var RespawnTime : float = 5
## Determines the default sprint speed of players.
@export var SprintSpeed : float = 25
## Determines the default stamina of players.
@export var Stamina : float = 0
## Determines whether or not stamina is enabled by default for players.
@export var StaminaEnabled : bool = true
## Determines the default rate at which stamina regenerates after being depleted for players.
@export var StaminaRegen : float = 1.2
## Determines how fast the player walks by default.
@export var WalkSpeed : float = 16
