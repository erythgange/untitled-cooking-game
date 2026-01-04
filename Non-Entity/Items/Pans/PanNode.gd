extends ItemNode
class_name PanNode

@export var max_ingredients: int
@onready var ingredient_array: Array[IngredientNode]

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:	
	## Debug
	debug_label.text = id
	

func _physics_process(delta: float) -> void:
	## Ingredient on top of pan
	if ingredient_array.is_empty() == false: 
		for item in ingredient_array:
			item.position = position + (ingredient_array.find(item) * Vector3(0,.25,0))
			item.rotation = rotation + (ingredient_array.find(item) * Vector3(0,.25,0))
			#var rot_to = rotation  + (ingredient_array.find(item) * Vector3(0,.25,0))
			#item.rotation = lerp(item.rotation, rot_to, delta)
	

			
func interact(player:CharacterBody3D) -> void:
	if player.held_item is IngredientNode:
		add_ingredients(player.held_item)
	else:
		pickup(player)
		

func add_ingredients(item) -> void:
	if item.current_state == "Chopped":
		ingredient_array.append(item)
		item.set_collision_layer_value(3, false) # make the ingredient inside the pan uninteractable
		item = null
		if ingredient_array.size() > 3:
			var last_ingredient = ingredient_array.pop_back()
			last_ingredient.apply_impulse(Vector3(0,5,0))
		
		
func clear_ingredient_array() -> void:
	for item in ingredient_array:
		item.queue_free()
	ingredient_array.clear()

func pickup(player: CharacterBody3D) -> void:
	player.held_item = self
	#freeze = true
	set_collision_layer_value(3, false)
