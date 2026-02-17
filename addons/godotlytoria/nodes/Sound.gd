@tool
@icon("res://addons/godotlytoria/textures/Sound.svg")
extends PolyDynamicInstance
## Sounds are objects that can be placed in the world and emit audio.
class_name PolySound

var sprite3D: Sprite3D = Sprite3D.new()
var StreamPlayer: AudioStreamPlayer3D = AudioStreamPlayer3D.new()

## The event that is fired when the sound is loaded from the server.
signal Loaded

## Plays the sound.
func Play(): pass
## Plays the sound once, able to be ran in rapid succession without stopping existing playback
func PlayOneShot(): pass
## Stops playing the sound.
func Stop(): pass

var Loading: bool
var Length: float

## The asset ID of the sound.
@export var SoundID: int = 1234

## File path for Godotlytoria to play your sound for development purposes. 
## Godotlytoria cannot currently load sounds directly from ID. Input your ID and download the file to your project using the download button.
## The download button will take you to a JSON page, just click the MP3 link and insert it into your project.
@export_file("*.mp3","*.wav","*.ogg") var SoundPath: String = "":
	set(value):
		SoundPath = value
		if value != "":
			StreamPlayer.stream = load(value)
		


## Download the sound from Polytoria using your web browser.
@export_tool_button("Download") var download = func ():
	if SoundID != 0:
		OS.shell_open(Polytoria.APIGetAudio(str(SoundID)))
	pass
	
## Determines whether the sound should start playing automatically.
@export var Autoplay: bool

## Determines whether or not the sound is currently playing or not.
@export var Playing: bool:
	set(value):
		Playing = value
		StreamPlayer.playing = value
		
## When enabled, the sound will be played in 3D world space rather than having the same volume for everyone.
@export var PlayInWorld: bool:
	set(value):
		PlayInWorld = value
		StreamPlayer.attenuation_model = AudioStreamPlayer3D.ATTENUATION_DISABLED if !value else AudioStreamPlayer3D.ATTENUATION_INVERSE_DISTANCE

## Determines whether the sound should loop or not.
@export var Loop: bool:
	set(value):
		Loop = value
		StreamPlayer.set("parameters/looping",value)
		
## The pitch of the sound.
@export var Pitch: float = 1.0:
	set(value):
		if value > 0.01:
			StreamPlayer.pitch_scale = value
			Pitch = value
		
## The volume of the sound.
@export var Volume: float:
	set(value):
		StreamPlayer.volume_db = value
		Volume = value

## Specifies how far the player must be from the sound for it to stop playing, if the PlayInWorld property is set to true.
@export var MaxDistance: float:
	set(value):
		StreamPlayer.max_distance = value
		MaxDistance = value
		
func _enter_tree() -> void:
	if sprite3D == null:
		sprite3D = Sprite3D.new()
	if StreamPlayer == null:
		StreamPlayer = AudioStreamPlayer3D.new()
	if SoundPath != "":
		StreamPlayer.stream = load(SoundPath)
	sprite3D.pixel_size = 0.05
	sprite3D.texture = load("res://addons/godotlytoria/textures/Sound.svg")
	sprite3D.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	add_child(StreamPlayer)
	add_child(sprite3D)
	sprite3D.owner = self
	StreamPlayer.volume_db = Volume
	StreamPlayer.playing = Playing
	StreamPlayer.pitch_scale = Pitch
	StreamPlayer.max_distance = MaxDistance
	StreamPlayer.attenuation_model = AudioStreamPlayer3D.ATTENUATION_DISABLED if !PlayInWorld else AudioStreamPlayer3D.ATTENUATION_INVERSE_DISTANCE
	
func _exit_tree() -> void:
	remove_child(sprite3D)
	remove_child(StreamPlayer)
