# Godotlytoria
Godotlytoria is a Polytoria Place Creator and Editor in the form of a Godot plugin for the Godot Editor. It allows you to make Polytoria games using Godot. 

The plugin attempts to serve as an alternative for the current Polytoria Creator due to it's poor UI and limited features.

# Installation
It is recommended to download Godotlytoria or use ``git clone`` and open it with Godot 4.5+

# Usage
## Opening a .poly file
Select **Scene**, then *Open Scene*, change types from recognized to *All types* and then select a .poly file. It will then load. Depending on how large the file is, it may take a while to load.
## Creating a .poly file
Create a new scene in Godot and set the root of the scene to "PolyGame", it will then generate you a basic template place. You may then save the scene as a .poly file.
## Running a .poly file
Press the red Polytoria button in the right hand corner of your screen. It will prompt you for a poly file to load, select it and it will run the client in solo mode with your .poly file. If nothing happens, check the settings to ensure that you have set the location of your Polytoria binaries, so Godotlytoria can run Polytoria.
# Features
- Custom settings tab
- Custom run button for your places

# Roadmap
[X] Ability to open the client and creator from Godot
[X] Ability to load .poly files
[X] Ability to save .poly files 
[X] Write Lua externally and connect to scripts via a file path.
[ ] Ability to code in GDScript and convert it to Lua 
[ ] Ability to code in Lua for Polytoria

# Credits
GodotXML by elenakrittik

# Have fun!
