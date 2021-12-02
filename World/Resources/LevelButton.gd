extends TextureButton

func _on_LevelButton_pressed() -> void:
	var root=get_node("/root")
	var scene = get_node("../../")
	var next_scene_resource = load("res://World/Levels/"+$Label.text+".tscn")
	var next_scene = next_scene_resource.instance()
	root.remove_child(scene)
	scene.call_deferred("queue_free")
	root.add_child(next_scene)
