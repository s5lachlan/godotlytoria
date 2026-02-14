# Godotlytoria
<img src="./icon.png" alt="" width="200px"/>

Godotlytoria is a [Polytoria](https://polytoria.com) Place Creator and Editor in the form of a Godot plugin for the Godot Editor. It allows you to make and edit Polytoria games using Godot. 

![](./screenshots/screenshot1.png)

## An alternative to the Creator.
The current Polytoria Creator is lacking in features, has a very displeasing UI, not modifiable and not very servicable for use for a serious game editor. I created Godotlytoria in a very short timespan, about 3 to 4 days in total, utilizing Godot as the perfect base for a place editor. However, I cannot guarantee that there will be no issues. If you would like to contribute or report bugs, please do so. 

## Usage
[Download Godotlytoria](https://github.com/s5lachlan/godotlytoria/archive/refs/heads/main.zip) and open it as a Godot Project.
### Opening a .poly file
Select **Scene**, then *Open Scene*, change types from recognized to *All types* and then select a .poly file. It will then load. Depending on how large the file is, it may take a while to load. You can also double click the file from the FileSystem dock but currently doing so will cause the scene to load twice, which is inefficient.
### Creating a .poly file
Create a new scene in Godot and set the root of the scene to "PolyGame", it will then generate you a basic template place. You may then save the scene as a .poly file.
### Running a .poly file
Press the red Polytoria button in the right hand corner of your screen. It will prompt you for a poly file to load, select it and it will run the client in solo mode with your .poly file. If nothing happens, check the settings to ensure that you have set the location of your Polytoria binaries, so Godotlytoria can run Polytoria.
### Scripting
LuaLS and .luarc.json are included in this repo, open am external editor for coding in Lua, such as Zed, and set the Script Path of scripts to your lua files. Godotlytoria will set the Source of the script objects to the contents of the file when the place is saved.

## Roadmap
- [x] Ability to open the client and creator from Godot
- [x] Ability to load .poly files
- [x] Ability to save .poly files 
- [x] Write Lua externally and connect to scripts via a file path.
- [ ] Ability to code in GDScript and convert it to Lua 

Likely to not support the following (unless I figure the API out)

- Toolbox
- Publishing directly to Polytoria
- Viewable models, assets, sounds and anything that requires fetching from Polytoria.

## Credits
GodotXML by elenakrittik. LuaLS files from GoldenretriverYT.

## Have fun!
