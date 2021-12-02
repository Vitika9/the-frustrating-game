extends Area2D

signal parent_ready
onready var player=get_node("../../../Player")
onready var parent=get_node("../")

func _ready() -> void:
	connect("parent_ready",self,"on_Parent_parent_ready")
	
func _on_AnimationStartPoint_body_entered(body: Node) -> void:
	parent.animatedSprite.playing=true
	parent.get_node("AudioStreamPlayer2D").playing=true
	player.set_physics_process(false)
	$AnimationPlayer.play("Animate")
	monitoring=false
	var camera=get_node("../Camera2D")
	
	if(camera!=null):
		var playerCam=player.get_node("Camera2D")
		camera.limit_bottom=playerCam.limit_bottom
		camera.limit_left=playerCam.limit_left
		camera.limit_right=playerCam.limit_right
		camera.limit_top=playerCam.limit_top
		camera.current=true
	
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	parent.ready()
	yield(get_tree().create_timer(.5),"timeout")
	player.set_physics_process(true)
	player.get_node("Camera2D").current=true
	queue_free()

func on_Parent_parent_ready():
	parent.set_physics_process(false)
