@tool
@icon("res://addons/godotlytoria/textures/Camera.svg")
extends PolyDynamicInstance
## Camera is a class that represents the local player's camera.
##
##[color=khaki]This object cannot be created by scripts using Instance.New().[br]
##[color=medium_purple]This object is automatically created by Polytoria. Additionally, scripts cannot change its parent.[br]
##[/color]
class_name PolyCamera

## Determines the distance between the camera and the player when the camera is in FollowPlayer mode.
@export var Distance: float
## Determines or returns the camera's field of view.
@export var FOV: float
## Determines the camera speed when the camera is in FreeCam mode while holding shift.
@export var FastFlySpeed: float
## Determines the camera speed when the camera is in FreeCam mode.
@export var FlySpeed: float
## Determines whether or not to use lerping in FollowPlayer mode.
@export var FollowLerp: bool
## Determines the mouse sensitivity while in FreeCam mode.
@export var FreeLookSensitivity: float
## Determines the horizontal movement speed of the camera in FollowPlayer mode.
@export var HorizontalSpeed: float 
## Returns whether or not the camera is in first person.
@export var IsFirstPerson: bool
## Determines the lerp speed of the camera when lerping is enabled
@export var LerpSpeed: float
## Determines camera's maximum distance from the player in FollowPlayer mode.
@export var MaxDistance: float
## The camera's minimum distance from the player in FollowPlayer mode.
@export var MinDistance: float
## Determines or returns the camera's current mode (Scripted, FollowPlayer, Freecam).
@export var Mode: Polytoria.CameraMode
## Determines whether or not the camera should render in orthographic (2D) mode or not (3D).
@export var Orthographic: bool
## Determines the half-size of the camera when in orthographic mode.
@export var OrthographicSize: float 
## Determines the camera's offset from its position.
@export var PositionOffset: Vector3
## Determines the camera's offset from its rotation.
@export var RotationOffset: Vector3
## Determines the scroll move speed of the camera.
@export var ScrollSensitivity: float
## Determines the vertical move speed of the camera.
@export var VerticalSpeed: float 
## Determines whether or not the camera should clip through walls.
@export var ClipThroughWalls: bool 
## Determines the multiplier of the camera sensitivity.
@export var SensitivityMultiplier: float
