extends RigidBody3D
class_name KitchenNode

# Chopping Board, Counter, Pantry, Stove, TrashBin
const BEEF = preload("uid://j6atit0h6jtr")


@export var id: String
@export var pantry_item: PackedScene = null 
@onready var interact_point: Area3D = $InteractPoint
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if id == null: breakpoint # ID should not be missing

func _process(_delta: float) -> void:
	### Debug
	$DebugLabel.text = id

func interact_kitchen_node(player:CharacterBody3D):
	
	## Pantry
	if id == "Pantry" and pantry_item: # If pantry and there is a pantry item
			
		if player.held_item == null or player.held_item == PanNode:
			var instance = pantry_item.instantiate()
			instance.position = interact_point.global_position
			add_sibling(instance)
		
			if player.held_item == PanNode:
				player.held_item.ingredient_array.append(instance)
				breakpoint
				
			else:
				player.held_item = instance
				player.held_item.freeze = true
			
			#print("Pantry: Spitting one out")
			#add cooldown


	# check if holding a plate or not
	if id == "TrashBin":
		if player.held_item != null:
			player.held_item.queue_free()	

	elif id == "Counter":
		player.held_item.global_position = interact_point.global_position
		player.held_item = null
			
	elif id == "Stove":
		player.held_item.global_position = interact_point.global_position
		player.held_item = null


			#var tween = create_tween()
			#tween.tween_property(player.held_item, "global_position", interact_point.global_position, 0.5)
