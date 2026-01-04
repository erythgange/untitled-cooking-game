extends RigidBody3D
class_name KitchenNode

# Chopping Board, Counter, Pantry, Stove, TrashBin
const BEEF = preload("uid://j6atit0h6jtr")


@export var id: String
@export var pantry_item: PackedScene = null
@onready var current_ingredient: IngredientNode = null
@onready var current_pan: PanNode = null
@onready var interact_point: Area3D = $InteractPoint
@onready var animation_player: AnimationPlayer = $AnimationPlayer
	
func _ready() -> void:
	if id == null: breakpoint # ID should not be missing

func _process(_delta: float) -> void:
	### Debug
	$DebugLabel.text = id

func interact_kitchen_node(player:CharacterBody3D):
	print("interacting with a kitchen node")
	
	## Pantry
	if id == "Pantry" and pantry_item: # If pantry and there is a pantry item
		print("interacting with pantry")	
			
		if player.held_item is PanNode:
			player.held_item.add_ingredients(spawn_ingredient())
			
		elif player.held_item == null:
			player.held_item = spawn_ingredient()
		
	if id == "ChoppingBoard":
		if player.held_item == null and current_ingredient.current_state == "Raw":
			current_ingredient.processing = true
			#player chopping animation
		
		elif player.held_item == null or player.held_item is PlateNode:
			player.held_item = current_ingredient
			release_ingredient()
			
		elif player.held_item is IngredientNode and player.held_item.current_state == "Raw":
			current_ingredient = player.held_item
			player.held_item.global_position = interact_point.global_position
			player.held_item = null


	# check if holding a plate or not
	if id == "TrashBin":
		if player.held_item != null:
			if player.held_item is IngredientNode:
				player.held_item.queue_free()
			elif player.held_item is PanNode:
				if player.held_item.ingredient_array.is_empty() == false: # If the Pan has items,
					player.held_item.clear_ingredient_array() # clear it

	elif id == "Counter":
		if player.held_item != null:
			player.held_item.global_position = interact_point.global_position
			player.held_item = null
			
	elif id == "Stove":
		if player.held_item is PanNode:
			player.held_item.global_position = interact_point.global_position
			player.held_item = null

func spawn_ingredient():
	var instance = pantry_item.instantiate()
	instance.position = interact_point.global_position
	add_sibling(instance)
	return instance

func release_ingredient() -> void:
	current_ingredient.apply_impulse(Vector3(0,5,0))
	current_ingredient == null
	
	# FIGURE OUT SIGNALS 
	
	
			#var tween = create_tween()
			#tween.tween_property(player.held_item, "global_position", interact_point.global_position, 0.5)
