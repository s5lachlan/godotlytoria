@tool
extends EditorPlugin

var pluginEnabled = false

# Names of scripts and their locations
var scripts = {
	"Settings": preload("res://addons/godotlytoria/scripts/ui_settings.gd").new(),
	"RunBar": preload("res://addons/godotlytoria/scripts/ui_run_bar.gd").new(),
}
# Singletons and their paths
var singletons = {
	"Polytoria": "res://addons/godotlytoria/scripts/autoload.gd"
}

# Ensure plugin loads correctly on startup
func _enter_tree() -> void:
	if !pluginEnabled:
		_enable_plugin()

# Enables singletons, sub-plugins and scripts
func _enable_plugin() -> void:
	if !pluginEnabled:
		print("[Polytoria] Plugin started")
		for singleton in singletons.keys():
			add_autoload_singleton(singleton,singletons[singleton])
		for script in scripts.keys():
			add_child(scripts[script])
		pluginEnabled = true

# Disables singletons, scripts and sub-plugins on disable or shutdown.
func _disable_plugin() -> void:
	for singleton in singletons.keys():
		remove_autoload_singleton(singleton)
	for script in scripts.keys():
		remove_child(scripts[script])
	pluginEnabled = false
	print("[Polytoria] Plugin stopped")
