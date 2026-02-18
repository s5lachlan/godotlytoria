# .poly File Loader.
# This script is responsible for parsing in .poly files as Godot Scenes

@tool
class_name PolyFileLoader
extends ResourceFormatLoader

func _recognize(resource: Resource) -> bool:
	# Only handle PackedScene resources.
	return resource is PackedScene

func _handles_type(typename: StringName) -> bool:
	return typename == &"PackedScene"

func _get_recognized_extensions() -> PackedStringArray:
	# Register .poly
	return ["poly","ptmd"]

func _get_resource_type(path: String) -> String:
	if path.ends_with(".poly") or path.ends_with(".ptmd"):
		return "PackedScene"
	else:
		return ""

# Check if class exists
func class_exists(name):
	for c in ProjectSettings.get_global_class_list():
		if c.class == name:
			return true
	return false
	
func get_class_from_db(name):
	for c in ProjectSettings.get_global_class_list():
		if c.class == name:
			return c
	return null
	
static func instantiate_class(name):
	for c in ProjectSettings.get_global_class_list():
		if c.class == name:
			return load(c.path).new()
	return PolyInstance.new()

func _load(path: String, original_path: String, use_sub_threads: bool, cache_mode: int) -> Variant:
	print("[Polytoria] Loading ", path)
	if !FileAccess.file_exists(path):
		print("[Polytoria] Error, place could not be found.")
		return
	var root = PolyGame.new()
	var scene = PackedScene.new()
	var xml = XML.parse_file(path)
	root.name = "Game"

	var recurse = func(recurse, xmlnode : XMLNode,parentNode):
		for item : XMLNode in xmlnode.children:
			if item.name == "Item":
				var itemClass = item.attributes["class"]
				var itemName = str(item.Properties.get_child_by_attr_name("Name").content)
				var newNode = PolyInstance.new()
				
				if class_exists("Poly" + itemClass):
					newNode = instantiate_class("Poly" + itemClass)
				else:
					print("[Polytoria] Couldn't find ", "Poly" + itemClass,". Please implement.")
				set_node_properties(item,newNode)
				newNode.name = itemName
				parentNode.add_child(newNode,true)
				newNode.owner = root
				recurse.call(recurse,item,newNode)
			
	recurse.call(recurse,xml.root,root)
	# Load .ptmd files 
	if xml.root.name == "model" and root.get_child_count() == 1:
		root = root.get_child(0)
		var recurseowner = func(recurse, node):
			for i in node.get_children():
				i.owner = root
				recurse.call(recurse, i)
		recurseowner.call(recurseowner, root)
	
	if scene.pack(root) == OK:
		print("[Polytoria] Scene loaded successfully.")
		return scene
		
	return ERR_CANT_CREATE

func set_node_properties(item : XMLNode, newNode : PolyInstance):
	var XMLProperties = prop_to_dict(item.Properties)
	var GDNodeProperties = newNode.get_properties()
	for variable in GDNodeProperties:
		var variableName = variable.name.trim_prefix("_")
		if XMLProperties.has(variableName):
			newNode.set(variable.name,XMLProperties[variableName])

func prop_to_dict(properties):
	var dict = {}
	for i in properties.children:
		match i.name:
			"boolean":
				dict[i.attributes.name] = str_to_var(i.content)
			"float":
				dict[i.attributes.name] = float(i.content)
			"token":
				dict[i.attributes.name] = int(i.content)
			"string":
				dict[i.attributes.name] = str(i.content)
			"int":
				dict[i.attributes.name] = int(i.content)
			"color":
				dict[i.attributes.name] = Color(float(i.R.content), float(i.G.content), float(i.B.content), float(i.A.content))
			"vector3":
				dict[i.attributes.name] = Vector3(float(i.X.content), float(i.Y.content), float(i.Z.content))
			_:
				print("What is... ", i.name, "?")
				dict[i.attributes.name] = i.content
	return dict
