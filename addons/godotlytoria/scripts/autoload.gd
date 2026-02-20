@tool
extends EditorPlugin

var PolyClientLocationOverride = ""
var PolyCreatorLocationOverride = ""
var UserHome = ""
var ExecutableType = ""

const ClientBinary = "Polytoria Client"
const CreatorBinary = "Polytoria Creator"
const LinuxExecutable = ".x86_64"
const WindowsExecutable = ".exe"

var DefaultClientFolder = ""
var DefaultCreatorFolder = ""
const DefaultLinuxPolyClientFolder = ".var/app/com.polytoria.launcher/config/Polytoria/Client/"
const DefaultLinuxPolyCreatorFolder = ".var/app/com.polytoria.launcher/config/Polytoria/Creator/"
const DefaultWindowsPolyClientFolder = "%appdata%\\Polytoria\\Client\\"
const DefaultWindowsPolyCreatorFolder = "%appdata%\\Polytoria\\Creator\\"

const FontPath = "res://addons/godotlytoria/fonts/"
const MaterialPath = "res://addons/godotlytoria/textures/materials/"
const ModelPath = "res://addons/godotlytoria/models/"
const SkyboxPath = "res://addons/godotlytoria/skyboxes/"

const RootNodes = [
		"Environment",
		"Lighting",
		"Players",
		"ScriptService",
		"Hidden",
		"ServerHidden",
		"PlayerDefaults",
		"PlayerGUI"
	]

func APIGetMesh(id: String) -> String:
	return "https://api.polytoria.com/v1/assets/serve-mesh/%s" % [id]
func APIGetAudio(id: String) -> String:
	return "https://api.polytoria.com/v1/assets/serve-audio/%s" % [id]
func APIGetDecal(id: String) -> String:
	return "https://api.polytoria.com/v1/assets/serve/ID/%s" % [id]
func APIGetModel(id: String) -> String: 
	return "https://api.polytoria.com/v1/models/get-model?id=%s" % [id]
func APIToolbox(page: String, query: String) -> String:
	return "https://api.polytoria.com/v1/models/toolbox?page=%s&q=%s" % [page, query]


enum AmbientSource {
	Skybox,
	AmbientColor
}

enum CameraMode {
	Scripted, 
	FollowPlayer,
	FreeCam
}

enum CollisionType {
	Bounds,
	Convex,
	Exact
}

enum ForceMode {
	Force,
	Acceleration,
	Impulse,
	VelocityChange
}

enum HorizontalAlignment {
	Left,
	Middle,
	Right
}

enum ImageType {
	Asset,
	AssetThumbnail,
	PlaceThumbnail,
	UserAvatarHeadshot,
	GuildIcon
}

enum PartMaterial {
	SmoothPlastic,
	Wood,
	Concrete,
	Neon,
	Metal,
	Brick,
	Grass,
	Dirt,
	Stone,
	Snow,
	Ice,
	RustyIron,
	Sand,
	Sandstone,
	Plastic,
	Plywood,
	Planks,
	MetalGrid,
	MetalPlate,
	Fabric,
	Marble
}

func get_material(material: PartMaterial):
	return load(MaterialPath + PartMaterial.keys()[material].to_lower() + "/albedo.png")

enum PartShape {
	Brick,
	Ball,
	Cylinder,
	Wedge,
	Truss,
	TrussFrame,
	Bevel,
	QuarterPipe,
	Cone,
	CornerWedge
}

func get_part_shape(shape: PartShape):
	return load(ModelPath + PartShape.keys()[shape].to_lower() + ".obj")

enum ParticleColorMode {
	Multiply,
	Additive,
	Subtractive,
	Overlay,
	Color,
	Difference
}

enum ParticleShape {
	Sphere,
	Hemisphere,
	Cone,
	Box,
	Donut,
	Circle,
	Rectangle
}

enum ParticleSimulationSpace {
	Local,
	World
}

enum PhysicsMaterialCombine {
	Average,
	Minimum,
	Multiply,
	Maximum
}

enum SkyboxPreset {
	Day1, ## A blue sky with clouds
	Day2, ## A blue sky with clouds
	Day3, ## A blue sky with clouds
	Day4, ## A blue sky with clouds
	Day5, ## A blue sky with clouds
	Day6, ## A blue sky with clouds
	Day7, ## A blue sky with clouds
	Morning1, ## A morning sky with clouds
	Morning2, ## A morning sky with clouds
	Morning3, ## A morning sky with clouds
	Morning4, ## A morning sky with clouds
	Night1, ## A night sky with stars
	Night2, ## A night sky with stars
	Night3, ## A night sky with stars
	Night4, ## A night sky with stars
	Night5, ## A night sky with stars
	Sunset1, ## A dusk red sky with clouds
	Sunset2,  ## A dusk red sky with clouds
	Sunset3,  ## A dusk red sky with clouds
	Sunset4,  ## A dusk red sky with clouds
	Sunset5,  ## A dusk red sky with clouds
}

func get_skybox(skybox: SkyboxPreset):
	return load(SkyboxPath + SkyboxPreset.keys()[skybox].to_lower() + ".tres")

enum TextFontPreset {
	SourceSans,
	PressStart2P,
	Montserrat,
	RobotoMono,
	Rubik,
	Poppins,
	Domine,
	Fredoka,
	ComicNeue,
	Orbitron,
	Papyrus,
	ComicSansMS
}

func get_font(font: TextFontPreset):
	return load(FontPath + TextFontPreset.keys()[font].to_lower() + ".ttf")

enum TextJustify {
	Left,
	Center,
	Right,
	Justify,
	Flush
}

enum TextVerticalAlign {
	Top,
	Middle,
	Bottom
}

enum TweenType {
	easeInBack,
	easeInBounce,	
	easeInCirc,	
	easeInCubic,	
	easeInElastic,	
	easeInExpo,	
	easeInOutBack,	
	easeInOutBounce,	
	easeInOutCirc,	
	easeInOutCubic,	
	easeInOutElastic,	
	easeInOutExpo,	
	easeInOutQuad,	
	easeInOutQuart,	
	easeInOutQuint,	
	easeInOutSine,	
	easeInQuad,	
	easeInQuart,	
	easeInQuint,	
	easeInSine,	
	easeOutBack,	
	easeOutBounce,	
	easeOutCirc,	
	easeOutCubic,	
	easeOutElastic,	
	easeOutExpo,	
	easeOutQuad,	
	easeOutQuart,	
	easeOutQuint,	
	easeOutSine,	
	linear,	
	punch
}

enum VerticalAlignment {
	Top,
	Middle,
	Bottom
}

func _enter_tree() -> void: 
	match OS.get_name():
		"Linux":
			UserHome = OS.get_environment("HOME")
			ExecutableType = LinuxExecutable
			if UserHome == "": 
				push_error("User's home is an empty string or doesn't exist.")
				return
			DefaultClientFolder = correct_path(UserHome) + DefaultLinuxPolyClientFolder
			DefaultCreatorFolder = correct_path(UserHome) + DefaultLinuxPolyCreatorFolder
		"Windows":
			UserHome = OS.get_environment("USERPROFILE")
			ExecutableType = WindowsExecutable
			if UserHome == "": 
				push_error("User's home is an empty string or doesn't exist.")
				return
			DefaultClientFolder = correct_path(UserHome) + DefaultWindowsPolyClientFolder
			DefaultCreatorFolder = correct_path(UserHome) + DefaultWindowsPolyCreatorFolder
	
# Polytoria binaries come in folders labeled with version numbers.
# This function's purpose is to scan all folders inside of Client/ and get the executable.
func scan_versions(folder,file_to_find):
	for version in DirAccess.get_directories_at(correct_path(folder,UserHome)):
		var expectedFile = correct_path(folder,UserHome) + correct_path(version) + file_to_find
		if FileAccess.file_exists(expectedFile):
			print("[Polytoria] Located ",file_to_find, " at: ", expectedFile)
			return expectedFile
	push_error("[Polytoria] Cannot find " + file_to_find)
	return

# This function corrects the path by appending a required prefix and appending the required suffix
func correct_path(path: String, prefix = ""):
	if prefix != "":
		if !path.begins_with(prefix):
			path = prefix + path
	if !path.ends_with("/"):
		return path + "/"
	else:
		return path

func run_client(path : String):
	var clientLocation = scan_versions(DefaultClientFolder,ClientBinary + ExecutableType)
	if PolyClientLocationOverride != "":
		clientLocation = correct_path(PolyClientLocationOverride,UserHome)
	print("[Polytoria] Running " + ProjectSettings.globalize_path(path))
	print("[Polytoria] Executed " + clientLocation)
	print("[Polytoria] Running Client in Offline Mode")
	if !path.ends_with(".poly"):
		print("[Polytoria] Cannot run a non .poly file")
		return
	OS.create_process(clientLocation,["-solo",ProjectSettings.globalize_path(path)])
	
func run_creator():
	var creatorLocation = scan_versions(DefaultCreatorFolder,CreatorBinary + ExecutableType)
	if PolyCreatorLocationOverride != "":
		creatorLocation = correct_path(PolyCreatorLocationOverride,UserHome)
	print("[Polytoria] Executed " + creatorLocation)
	print("[Polytoria] Running Creator in Offline Mode")
	OS.create_process(creatorLocation,["-token","0"])
