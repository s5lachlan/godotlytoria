# .poly File Saver.
# This script is responsible for saving Godot Scenes as .poly files

@tool
class_name PolyFileSaver
extends ResourceFormatSaver

const gameFile = """<?xml version="1.0" encoding="UTF-8"?>
<game version="%s">%s
</game>"""

const modelFile = """<?xml version="1.0" encoding="UTF-8"?>
<model version="%s">%s
</model>"""


# Only handle PackedScene resources.
func _recognize(resource: Resource) -> bool:
	return resource is PackedScene

# Recognize .poly extension only. Plan to add .ptmd support later.
func _get_recognized_extensions(resource: Resource) -> PackedStringArray:
	return PackedStringArray(["poly"])

func _save(resource: Resource, path: String, flags: int) -> Error:
	# Set initial variables.
	var scene: PackedScene = resource as PackedScene
	# Get scene as scene state without instantiating it.
	# Scene state is a huge list of nodes, no children or parent information, just one after another.
	var state: SceneState = scene.get_state()
	# Current XML Item
	var xml = ""
	# Final file wrapper
	var final_file = """<?xml version="1.0" encoding="UTF-8"?>
<game version="%s">%s
</game>"""

	# Lambda functions that I felt like would work best inside this function

	var get_node_script = func(node):
		for i in state.get_node_property_count(node):
			if state.get_node_property_name(node,i) == "script":
				return state.get_node_property_value(node,i)
		return null
		
	var get_node_properties = func(node):
		var propertyList = get_default_values(get_node_script.call(node))
		for i in state.get_node_property_count(node):
			var name = state.get_node_property_name(node,i).trim_prefix("_")
			var value = state.get_node_property_value(node,i)
			if is_public(name):
				propertyList[name] = value
		return propertyList
		
	var get_node_depth = func(node, amount):
		return str(state.get_node_path(clamp(node + amount,0,state.get_node_count() - 1))).count("/")
		
	for node in state.get_node_count():
		# Skip game / root node and ignore nodes that don't have scripts.
		if node == 0 || get_node_script.call(node) == null:
			continue
			
		var nodexml = ""
		var last_node_depth = get_node_depth.call(node,-1)
		var current_node_depth = get_node_depth.call(node,0)
		var next_node_depth = get_node_depth.call(node,1)
		var node_class = get_script_class(get_node_script.call(node))
		var nodeProperties = get_node_properties.call(node)
		var hasChildren = (next_node_depth != current_node_depth)
		var ascendingTree = (next_node_depth < current_node_depth)
		var escaped = (last_node_depth > current_node_depth)

		if escaped: nodexml += "\n</Item>".repeat(last_node_depth - current_node_depth)
		nodexml += '\n<Item class="%s">\n' % [node_class]
		
		nodexml += xml_properties(nodeProperties).indent("  ")
		if !hasChildren:
			nodexml += "\n</Item>"
		if ascendingTree:
			nodexml += "\n</Item>"
		if current_node_depth - 1 > 0:
			nodexml = nodexml.indent("  ".repeat(current_node_depth))
		xml += nodexml
		
	final_file = final_file % [str(Polytoria.ClientVersion),xml.indent("  ")]
	var file = FileAccess.open(path,FileAccess.WRITE)
	print("[Polytoria] Saving to ", path)
	file.store_string(final_file)
	file.close()
	return OK

func get_script_class(script: GDScript):
	var property_list = script.get_script_property_list()
	for i in property_list:
		if i.name.ends_with(".gd"):
			return i.name.trim_suffix(".gd")

func get_default_values(script: GDScript):
	var property_list = script.get_script_property_list()
	var list = {}
	for i in property_list:
		if i.usage != PROPERTY_USAGE_SCRIPT_VARIABLE + PROPERTY_USAGE_STORAGE + PROPERTY_USAGE_EDITOR:
			continue
		if !is_public(i.name):
			continue
		if i.name.contains(".gd"):
			continue
		else:
			list[i.name.trim_prefix("_")] = script.get_property_default_value(i.name.trim_prefix("_"))
	return list
	
# Returns true if property begins with a capital letter.
	
func is_public(string: String):
	return string[0] == string[0].to_upper()
	
# XML functions
	
func xml_properties(properties):
	var string = ""
	var function: Callable
		
	for i in properties:
		match typeof(properties[i]):
			TYPE_INT: function = xml_int
			TYPE_FLOAT: function = xml_float
			TYPE_STRING: function = xml_string
			TYPE_BOOL: function = xml_boolean
			TYPE_COLOR: function = xml_color
			TYPE_VECTOR3: function = xml_vector3
			_: 
				# Stupid hack because the default value of colour is null for some reason
				match i:
					"Color": 
						properties[i] = Color.WHITE
						function = xml_color
					"Range":
						properties[i] = 60.0
						function = xml_float
					_: print("Error, cannot find variant: ",properties)
		string += (function.call(i,properties[i]) + "\n").indent("  ")
	return "<Properties>\n%s</Properties>" % [string]
	
func xml_boolean(name: String,boolean : bool):
	var string = """<boolean name="%s">%s</boolean>"""
	return string % [name,str(boolean)]
	
func xml_float(name: String,floatation: float):
	var string = """<float name="%s">%s</float>"""
	return string % [name,str(floatation)]
	
func xml_int(name: String,integer: int):
	var string = """<int name="%s">%s</int>"""
	return string % [name,str(integer)]
	
func xml_string(name: String,string: String):
	var _string = """<string name="%s">%s</string>"""
	return _string % [name,string]
	
func xml_color(name: String,color: Color):
	var string = """<color name="%s">
  <R>%s</R>
  <G>%s</G>
  <B>%s</B>
  <A>%s</A>
</color>"""
	return string % [name,str(color.r),str(color.g),str(color.b),str(color.a)]

func xml_vector3(name: String,vector: Vector3):
	var string = """<vector3 name="%s">
  <X>%s</X>
  <Y>%s</Y>
  <Z>%s</Z>
</vector3>"""
	return string % [name,str(vector.x),str(vector.y),str(vector.z)]
