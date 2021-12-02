extends Node2D

export var is_visible=true
onready var textureRect=$TextureRect
onready var collisionShapeOfArea2D=$Area2D/CollisionShape2D
onready var collisionShape2DOfHitBox=$HitBox/CollisionShape2D
var hitBox

func _ready() -> void:
	
	hitBox=$HitBox
	if(!is_visible):
		textureRect.visible=false
		hitBox.visible=false
	collisionShapeOfArea2D.position.x=textureRect.rect_size.x/2
	collisionShapeOfArea2D.position.y=textureRect.rect_size.y/2
	collisionShapeOfArea2D.shape.extents.y=textureRect.rect_size.y
	
	collisionShapeOfArea2D.shape.extents.x=textureRect.rect_size.x/2
	collisionShape2DOfHitBox.position.y=0
	collisionShape2DOfHitBox.position.x=textureRect.rect_size.x/2
	collisionShape2DOfHitBox.shape.extents.x=textureRect.rect_size.x/2-5
	
func _on_HitBox_body_entered(body: Node) -> void:
	if(textureRect.visible):
		body.queue_free()

func _on_Area2D_body_entered(body: Node) -> void:
	textureRect.visible=!textureRect.visible
	hitBox.visible=textureRect.visible
	
func _on_Area2D_body_exited(body: Node) -> void:
	textureRect.visible=!textureRect.visible
	hitBox.visible=textureRect.visible
	

