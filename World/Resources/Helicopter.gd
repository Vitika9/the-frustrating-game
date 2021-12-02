extends KinematicBody2D

export var range_from=0.0
export var range_to=1.0
export var is_in_area=false
onready var direction=1
onready var timer=$Timer
onready var animatedSprite=$Position2D/AnimatedSprite
onready var rayCast2D=$Position2D/RayCast2D
onready var position2D=$Position2D
onready var animationStartPoint=$AnimationStartPoint
onready var area2D=$Area2D
var velocity=Vector2(100,0)
var count=0

func _ready() -> void:
	area2D.position.x=position.x+area2D.position.x
	area2D.position.y=position.y+area2D.position.y
	area2D.set_as_toplevel(true)
	if(animationStartPoint!=null):
		animationStartPoint.emit_signal("parent_ready")
	elif is_in_area:
		ready()
	else:
		set_physics_process(false)
	
func _physics_process(delta: float) -> void:
	velocity=move_and_slide(velocity)
	if(rayCast2D.is_colliding()):
		velocity.x*=-1
		position2D.scale.x=-position2D.scale.x
		
func emit_bomb():
	var Bomb=load("res://World/Resources/Bomb.tscn")
	var bomb=Bomb.instance()
	bomb.position=position
	get_node("../").add_child(bomb)

func ready():
	set_physics_process(true)
	$AudioStreamPlayer2D.playing=true
	randomize()
	$Timer.start()
	
func _on_Timer_timeout() -> void:
	emit_bomb()
	timer.wait_time=rand_range(range_from,range_to)
	timer.start()

func _on_Area2D_body_entered(body: Node) -> void:
	print("enter")
	ready()

func _on_Area2D_body_exited(body: Node) -> void:
	print("exit")
	set_physics_process(false)
	timer.stop()
	$AudioStreamPlayer2D.playing=false

