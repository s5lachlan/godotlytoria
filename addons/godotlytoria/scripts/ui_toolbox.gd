@tool
extends EditorPlugin

var toolbox = preload("res://addons/godotlytoria/layouts/toolbox.tscn").instantiate()

var toolboxData: JSON

func _enter_tree() -> void: 
	toolbox.get_node("Search").connect("text_submitted",search)
	toolbox.get_node("SearchRequest").connect("request_completed",search_completed)
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR,toolbox)

func _exit_tree() -> void:
	if toolbox:
		remove_control_from_docks(toolbox)
		toolbox.queue_free()

func search(query):
	# This does not work. Sorry!
	return
	var api_request_string = Polytoria.APIToolbox("1",query)
	print(api_request_string)
	toolbox.get_node("SearchRequest").request(api_request_string)
	
func search_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	print("Result: ", result)
	print("Response code: ", response_code)
	print("Headers: ",headers)
	toolboxData = JSON.parse_string(body.get_string_from_utf8())
	print("Data: ", toolboxData)
