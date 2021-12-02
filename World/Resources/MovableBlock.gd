extends RigidBody2D
class_name MovableBlock

onready var collisionShape2D=$CollisionShape2D
onready var textureRect=$TextureRect

func _ready() -> void:
	collisionShape2D.position.x=textureRect.rect_size.x/2
	collisionShape2D.position.y=textureRect.rect_size.y/2
	collisionShape2D.shape.extents.x=textureRect.rect_size.x/2
	collisionShape2D.shape.extents.y=textureRect.rect_size.y/2
	
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	angular_velocity=0
	rotation_degrees=0
