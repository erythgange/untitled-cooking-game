extends RigidBody3D
class_name ItemNode

var DebugLabel := Label3D.new()
#var mesh : Mesh
#var collision : CollisionShape3D
@export var id: String
enum ipp {Ingredient, Plate, Pan}
@export var ItemType : ipp
