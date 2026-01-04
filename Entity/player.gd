extends CharacterBody3D

@onready var mesh: Node3D = $Mesh
@onready var camera: Node3D = $Camera
@onready var detector: ShapeCast3D = $Mesh/InteractBox
@onready var hold_point: Node3D = $Mesh/HoldPoint

var direction : Vector3
const accel :=  5.0
const friction := 5
const max_run_speed := 10
const delta_accel := 10

var held_item: RigidBody3D = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		interact()

func _physics_process(delta: float) -> void:
	
	## input values
	direction = Vector3(
		 Input.get_action_strength("right") - Input.get_action_strength("left"), 0.0,
		 Input.get_action_strength("down") - Input.get_action_strength("up")
	).rotated(Vector3.UP, camera.rotation.y).normalized()
	
	## Movement
	if not is_on_floor(): # on air
		velocity += get_gravity() * delta
	var velocity_weight = delta * (accel if direction else friction)
	velocity = lerp(velocity, direction * max_run_speed, velocity_weight)
	
	## Mesh orientation
	mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(velocity.x + direction.x, velocity.z + direction.z) + PI, .5)
		
	## If holding an item
	if held_item != null:
		#held_item.global_position = lerp(held_item.global_position, hold_point.global_position, delta_accel * delta)
		held_item.global_position = hold_point.global_position
		#held_item.rotation = hold_point.rotation
		held_item.rotation = lerp(held_item.rotation, Vector3.ZERO, 2 * delta)
		
	move_and_slide()


func interact():
	if not detector.is_colliding(): return
	var target = detector.get_collider(0)
	
	if target is KitchenNode:
		target.interact_kitchen_node(self)
		
	if target is ItemNode:
		target.interact(self)
