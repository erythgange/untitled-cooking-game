extends ItemNode
class_name IngredientNode

var processing := false
var ontop_of_kitchen: KitchenNode = null

@export var states : Array[String]
@export var state_timers : Array[int] # Time needed to chop, to cooked, to burnt
@export var kitchen : Array[PackedScene]
@export var pan : PackedScene

@onready var current_state : String = states[0]
@onready var state_progress : Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Reference: "Raw", "Chopped", "Cooked", "Burnt"
# Reference: "Pantry", "ChoppingBoard", "Stove", "Stove"


func _ready() -> void:
	if id.is_empty() or states.is_empty() or state_timers.is_empty() or kitchen.is_empty():
		breakpoint # Field shouldn't be empty
	state_progress.start(state_timers[0])
	
func _process(_delta: float) -> void:
	
	### Debugd
	debug_label.text = current_state + " " + id + "\n" + str(roundf(state_progress.time_left))
	
	## if on correct KitchenNode
	if processing == true:
		state_progress.paused = false
	else:
		state_progress.paused = true


func _state_progress_timeout() -> void:	
	var next_state = states.find(current_state) + 1
	current_state = states[next_state]
	
	if states[-1] != current_state:
		var next_state_timer = state_timers[next_state]
		state_progress.start(next_state_timer)
	
	## Special conditions
	if current_state == "Chopped":
		processing = false

func interact(player:CharacterBody3D) -> void:
	if player.held_item == null:
		player.held_item = self	
	elif player.held_item is PanNode:
			player.held_item.ingredient_array.append(self)
			set_collision_layer_value(3, false) # make the ingredient inside the pan uninteractable
			
	
