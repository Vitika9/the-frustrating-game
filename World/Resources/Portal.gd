extends Area2D

export var next_scene_name:String
export var is_final=true
var root
var scene

func _ready() -> void:
	scene = get_node("../../")
	if(!is_final):
		$Sprite.texture=load("res://World/Other/Portal.png")
	elif next_scene_name=="":
		next_scene_name=str(int(scene.scene_name)+1)
	root=get_node("/root")
	

func _on_FinalPortal_body_entered(player: Node) -> void:
	var next_scene_resource =load("res://World/Levels/"+next_scene_name+".tscn")
	var next_scene = next_scene_resource.instance()
	scene.add_child(load("res://World/Resources/LeavingScene.tscn").instance())
	yield(get_tree().create_timer(1.2),"timeout")
	root.remove_child(scene)
	scene.call_deferred("queue_free")
	root.add_child(next_scene)
