extends KinematicBody2D

export var count=1
onready var collisiionShape2D=$CollisionShape2D
onready var textureRect=$TextureRect
var current_count =0 setget set_current_count
var velocity=Vector2.ZERO
const GRAVITY=5
const MAX_FALLING_V=50

func _ready() -> void:
	set_physics_process(false)
	collisiionShape2D.position.x=textureRect.rect_size.x/2
	collisiionShape2D.position.y=textureRect.rect_size.y/2
	collisiionShape2D.shape.extents.x=textureRect.rect_size.x/2
	collisiionShape2D.shape.extents.y=textureRect.rect_size.y/2
	
func _physics_process(delta: float) -> void:
	velocity.y=min(velocity.y+GRAVITY,MAX_FALLING_V)
	move_and_collide(velocity)

func set_current_count(value):
	current_count=value
	if(current_count==count):
		yield(get_tree().create_timer(.3),"timeout")
		set_physics_process(true)
		
		$AudioStreamPlayer2D.playing=true
		yield(get_tree().create_timer(3),"timeout")
		queue_free()
		


func _on_Area2D_body_entered(body: Node) -> void:
	set_current_count(current_count+1)
