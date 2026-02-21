@icon("res://addons/godotlytoria/textures/icons/Particles.svg")
extends PolyDynamicInstance
class_name PolyParticles

# TODO: Fix and Implement, Add Godot functionality.

@export var ImageID: String 
@export var ImageType:  Polytoria.ImageType 
#@export var _Color:  Polytoria.ColorRange 
@export var ColorMode:  Polytoria.ParticleColorMode 
#@export var Lifetime:  Polytoria.NumberRange 
#@export var SizeOverLifetime:  Polytoria.NumberRange 
#@export var Speed:  Polytoria.NumberRange 
@export var EmissionRate : int 
@export var MaxParticles : int 
@export var Gravity: float 
@export var SimulationSpace:  Polytoria.ParticleSimulationSpace 
#@export var StartRotation:  Polytoria.NumberRange 
#@export var AngularVelocity:  Polytoria.NumberRange 
@export var Autoplay : bool 
@export var Loop : bool 
@export var Duration : float 
@export var Shape: Polytoria.ParticleShape 
@export var ShapeRadius : float 
@export var ShapeAngle : float 
@export var ShapeScale : float 
@export var IsPlaying : bool 
@export var IsPaused : bool 
@export var IsStopped : bool 
@export var ParticleCount : int 
@export var _Time: float 
@export var TotalTime : float
