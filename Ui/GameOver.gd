extends CanvasLayer

func _on_RestartButton_pressed() -> void:
	var root=get_node("/root")
	var scene = get_node(".")
	var next_scene_resource = load(Main.current_scene_path)
	var next_scene = next_scene_resource.instance()
	root.remove_child(scene)
	scene.call_deferred("queue_free")
	root.add_child(next_scene)


func _on_MenuButton2_pressed() -> void:
	var root=get_node("/root")
	var scene = get_node(".")
	var next_scene_resource = load("res://Ui/Levels.tscn")
	var next_scene = next_scene_resource.instance()
	root.remove_child(scene)
	scene.call_deferred("queue_free")
	root.add_child(next_scene)


func _on_CheckpointButton_pressed() -> void:
	var root=get_node("/root")
	var scene = get_node(".")
	var next_scene_resource = load(Main.current_scene_path)
	var next_scene = next_scene_resource.instance()
	next_scene.get_node("Player").position=Main.position
	root.remove_child(scene)
	scene.call_deferred("queue_free")
	root.add_child(next_scene)
