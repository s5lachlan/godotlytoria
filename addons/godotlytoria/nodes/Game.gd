@tool
@icon("res://addons/godotlytoria/textures/Game.svg")
extends PolyInstance
class_name PolyGame

var GameID: int
var InstanceCount: int
var LocalInstanceCount: int
var PlayersConnected: int

func _enter_tree() -> void:
	self.name = "Game"
	var _have = []
	var _expected = [
		"Environment",
		"Lighting",
		"Players",
		"ScriptService",
		"Hidden",
		"ServerHidden",
		"PlayerDefaults",
		"PlayerGUI"
	]
	for i in _expected:
		if get_node_or_null(i) == null:
			print("[Polytoria] Adding "+ i, " to game.")
			var node = PolyFileLoader.instantiate_class("Poly" + i)
			node.name = i
			node.Name = i
			add_child(node)
			node.owner = self
		
