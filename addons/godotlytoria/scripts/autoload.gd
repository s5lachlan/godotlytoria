@tool
extends EditorPlugin

var PolyClientLocation = ".var/app/com.polytoria.launcher/config/Polytoria/Client/" + ClientVersion + "/Polytoria Client.x86_64"
var PolyCreatorLocation = ".var/app/com.polytoria.launcher/config/Polytoria/Creator/" + CreatorVersion + "/Polytoria Creator.x86_64"
var UserHome = ""
const CreatorVersion = "1.4.154"
const ClientVersion = "1.4.155"
const DefaultLinuxPolyClientLocation = ".var/app/com.polytoria.launcher/config/Polytoria/Client/" + ClientVersion + "/Polytoria Client.x86_64"
const DefaultLinuxPolyCreatorLocation = ".var/app/com.polytoria.launcher/config/Polytoria/Creator/" + CreatorVersion + "/Polytoria Creator.x86_64"
const DefaultWindowsPolyClientLocation = "%appdata%\\Polytoria\\Client\\" + ClientVersion + "\\Polytoria Client.exe"
const DefaultWindowsPolyCreatorLocation = "%appdata%\\Polytoria\\Creator\\" + CreatorVersion + "\\Polytoria Creator.exe"
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
			if UserHome == "": 
				push_error("User's home is an empty string or doesn't exist.")
				return
			PolyClientLocation = UserHome + "/" + DefaultLinuxPolyClientLocation
			PolyCreatorLocation = UserHome + "/" + DefaultLinuxPolyCreatorLocation
		"Windows":
			UserHome = OS.get_environment("USERPROFILE")
			if UserHome == "": 
				push_error("User's home is an empty string or doesn't exist.")
				return
			PolyClientLocation = DefaultWindowsPolyClientLocation
			PolyCreatorLocation = DefaultWindowsPolyCreatorLocation
	

func run_client(path : String):
	print("[Polytoria] Running " + ProjectSettings.globalize_path(path))
	print("[Polytoria] Executed " + PolyClientLocation)
	print("[Polytoria] Running Client in Offline Mode")
	if !path.ends_with(".poly"):
		print("[Polytoria] Cannot run a non .poly file")
		return
	OS.create_process(PolyClientLocation,["-solo",ProjectSettings.globalize_path(path)])
	
func run_creator():
	print("[Polytoria] Executed " + PolyCreatorLocation)
	print("[Polytoria] Running Creator in Offline Mode")
	OS.create_process(PolyCreatorLocation,["-token","0"])
