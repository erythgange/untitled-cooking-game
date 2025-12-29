extends ItemNode
class_name PanNode

@onready var collision: CollisionShape3D = $Collision
@onready var debug_label: Label3D = $DebugLabel
@onready var interact_point: Node3D = $InteractPoint

@onready var ingredient_array: Array[IngredientNode]

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:	
	## Debug
	debug_label.text = id

func _physics_process(delta: float) -> void:
	## Ingredient on top of pan
	for i in ingredient_array:
		i.global_position = lerp(i.global_position, 10, delta * 10)
		breakpoint
