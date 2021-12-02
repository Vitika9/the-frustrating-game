extends Area2D

export(String) var scene_name
onready var path_to_next_level="res://World/Levels/"+scene_name+".tscn"

func _on_SceneChanger_body_entered(body: Node) -> void:
	if(body is Player):
		var root=get_node("/root")
		var scene = get_node("../")
		var next_scene_resource = load(path_to_next_level)
		var next_scene = next_scene_resource.instance()
		root.remove_child(scene)
		scene.call_deferred("queue_free")
		root.add_child(next_scene)

	
