extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var spring_position: Node3D = $SpringArm3D/SpringPosition

@export var follow_target: Node3D

var set_fov := 75
var yaw := float()
var pitch := float()
var sens := 0.002
var smoothness := 15
var offset := Vector3(0,0.5,0)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.fov = set_fov

func _physics_process(delta: float) -> void:
	position = lerp(position, follow_target.position + offset, smoothness * delta)
	camera.position = lerp(camera.position, spring_position.position, smoothness * delta)
	#camera.position = lerp(camera.position, camera.position, smoothness * delta)
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		
		rotation.y -= event.relative.x * sens
		rotation.y = wrapf(rotation.y, 0.0, TAU) # optimization
		
		rotation.x -= event.relative.y * sens
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(45)) #min,max
