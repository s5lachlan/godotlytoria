@tool
@icon("res://addons/godotlytoria/textures/Game.svg")
extends PolyInstance
## Game is the root object in the Polytoria instance tree. It is the object from which everything is descended.
## @tutorial: https://docs.polytoria.com/objects/game/Game/
class_name PolyGame

## The ID of the current Polytoria place.
var GameID: int
## The total number of instances currently loaded.
var InstanceCount: int
## The number of instances currently loaded on the client.
var LocalInstanceCount: int
## Returns the number of players connected to the game.
var PlayersConnected: int

## Fires every frame after the place has been rendered. The deltaTime parameter is the time between the last frame and the current.
signal Rendered(deltaTime: float)

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
		
