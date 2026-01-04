extends RigidBody3D
class_name ItemNode

@export var collision: CollisionShape3D
@export var debug_label: Label3D

var DebugLabel := Label3D.new()
#var mesh : Mesh
#var collision : CollisionShape3D
@export var id: String
enum ipp {Ingredient, Plate, Pan}
@export var ItemType : ipp
