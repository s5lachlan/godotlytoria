@tool
extends EditorPlugin

var run_bar = preload("res://addons/godotlytoria/layouts/run_bar.tscn").instantiate()

func _enter_tree() -> void: 
	run_bar.get_node("Creator").connect("pressed",Polytoria.run_creator)
	run_bar.get_node("Client").connect("pressed",func ():
		run_bar.get_node("OpenPolyFile").visible = true
	)
	run_bar.get_node("OpenPolyFile").connect("file_selected",Polytoria.run_client)
	add_control_to_container(
		EditorPlugin.CONTAINER_TOOLBAR,
		run_bar
	)

func _exit_tree() -> void:
	if run_bar:
		remove_control_from_container(
			EditorPlugin.CONTAINER_TOOLBAR,
			run_bar
		)
		run_bar.queue_free()
