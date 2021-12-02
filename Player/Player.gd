extends KinematicBody2D
class_name Player

onready var position2D=$Position2D
onready var animatedSprite=$Position2D/AnimatedSprite
onready var cpuParticles=$Position2D/CPUParticles2D
var velocity=Vector2.ZERO
var direction=0
var count=0
var can_jump=false
const JUMP=-250
const MAX_V_VELOCITY=150
const GRAVITY=12
const FLOOR_NORMAL=Vector2.UP
const SPEED=100
const BLOCK_SPEED=90
const PUSH=5
enum state{IDLE,RUN,JUMP}


func _ready() -> void:
	animatedSprite.play("Idle")
	if Main.music:
		$AudioStreamPlayer2D2.playing=true

func _physics_process(delta: float) -> void:
	apply_gravity()
	apply_motion()
	apply_jump()
	
	velocity=move_and_slide(velocity,FLOOR_NORMAL,false,4, 0.785398,false)
	
	for i in get_slide_count():
		var collision=get_slide_collision(i)
		if collision.collider is MovableBlock:
			collision.collider.apply_central_impulse(-collision.normal * PUSH)

func apply_gravity():
	velocity.y=min(velocity.y+GRAVITY,MAX_V_VELOCITY)

func apply_motion():
	direction=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	velocity.x=SPEED*direction
	
	if direction>0:
		position2D.scale.x=1
	elif direction<0:
		position2D.scale.x=-1

	if direction!=0:
		cpuParticles.emitting=true
	else:
		cpuParticles.emitting=false
	
func apply_jump():
	if((can_jump|| is_on_floor())&& Input.is_action_just_pressed("ui_up")):
		if(is_on_floor()):
			can_jump=true
		else:
			can_jump=false
			
		velocity.y=JUMP
	
func queue_free():
	if(count==0):
		count+=1
		visible=false
		
		set_physics_process(false)
		
		var PlayerDeathEffect=load("res://Effects/PlayerDeathEffect/PlayerDeathEffect.tscn")
		var playerDeathEffect=PlayerDeathEffect.instance()
		playerDeathEffect.position=position
		playerDeathEffect.playing=true
		var scene = get_node("../")
		scene.add_child(playerDeathEffect)
		
		$AudioStreamPlayer2D.playing=true
		
		yield(get_tree().create_timer(2.5),"timeout")
		var root=get_node("/root")
		var next_scene_resource = load("res://Ui/GameOver.tscn")
		var next_scene = next_scene_resource.instance()
		root.remove_child(scene)
		scene.call_deferred("queue_free")
		root.add_child(next_scene)
	

	
	








