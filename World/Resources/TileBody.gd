extends StaticBody2D
class_name TileBody

onready var collisionShape2DofCollisionDetector=$CollisionDetector/CollisionShape2D2
var move=true
var collisionShape2D
var textureRect

func _ready() -> void:
	
	collisionShape2D=$CollisionShape2D
	textureRect=$TextureRect
	
	collisionShape2D.position.x=textureRect.rect_size.x/2
	collisionShape2D.position.y=textureRect.rect_size.y/2
	collisionShape2DofCollisionDetector.position.x=collisionShape2D.position.x
	collisionShape2DofCollisionDetector.position.y=collisionShape2D.position.y
	collisionShape2D.shape.extents.x=textureRect.rect_size.x/2
	collisionShape2D.shape.extents.y=textureRect.rect_size.y/2
	collisionShape2DofCollisionDetector.shape.extents.x=5
	collisionShape2DofCollisionDetector.shape.extents.y=5
	collisionShape2DofCollisionDetector.disabled=false
	
func _on_Area2D_body_entered(body: Node) -> void:
	enableCollisionDetect()
	$AnimationPlayer.play("Animate")
	$AudioStreamPlayer2D.playing=true
	
func _on_CollisionDetector_body_entered(player: Node) -> void:
	if collisionShape2DofCollisionDetector.disabled==false:
		player.queue_free()
		
func enableCollisionDetect():
	$Area2D/CollisionShape2D.disabled=true
	collisionShape2DofCollisionDetector.disabled=false
	collisionShape2DofCollisionDetector.shape.extents.x=collisionShape2D.shape.extents.x+2
	collisionShape2DofCollisionDetector.shape.extents.y=collisionShape2D.shape.extents.y+2

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	collisionShape2DofCollisionDetector.disabled=true
