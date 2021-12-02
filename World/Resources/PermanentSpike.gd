extends Node2D

onready var textureRect=$TextureRect
onready var collisionShape2DOfHitBox=$HitBox/CollisionShape2D

func _ready() -> void:
	collisionShape2DOfHitBox.position.y=0
	collisionShape2DOfHitBox.position.x=textureRect.rect_size.x/2
	collisionShape2DOfHitBox.shape.extents.x=(textureRect.rect_size.x/2)-5


func _on_HitBox_body_entered(body: Node) -> void:
	body.queue_free()
