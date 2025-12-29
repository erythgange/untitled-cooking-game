extends ItemNode
class_name PlateNode

@onready var collision: CollisionShape3D = $Collision
@onready var debug_label: Label3D = $DebugLabel
@onready var interact_point: Node3D = $InteractPoint

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	
	## Debug
	debug_label.text = id
