@tool
extends EditorPlugin

var settings_tab = preload("res://addons/godotlytoria/layouts/settings.tscn").instantiate()

func set_settings():
	if ProjectSettings.get_setting("addons/polytoria/client_location"):
		Polytoria.PolyClientLocation = ProjectSettings.get_setting("addons/polytoria/client_location")
	if ProjectSettings.get_setting("addons/polytoria/creator_location"):
		Polytoria.PolyCreatorLocation = ProjectSettings.get_setting("addons/polytoria/creator_location")

func update_settings():
	ProjectSettings.set_setting("addons/polytoria/client_location",Polytoria.PolyClientLocation)
	ProjectSettings.set_setting("addons/polytoria/creator_location",Polytoria.PolyCreatorLocation)

func _enter_tree() -> void: 
	set_settings()
	for i in settings_tab.get_children():
		if i.name in Polytoria:
			if i is LineEdit:
				i.text = Polytoria.get(i.name)
				i.placeholder_text = Polytoria.get(i.name)
				i.connect("text_changed",
				func(new_text):
					Polytoria.set(i.name,new_text)
					update_settings()
				)
	add_control_to_container(
		EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT,
		settings_tab
	)

func _exit_tree() -> void:
	if settings_tab:
		remove_control_from_container(
			EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT,
			settings_tab
		)
		settings_tab.queue_free()
