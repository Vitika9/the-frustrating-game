extends Node2D

export var scene_name:String

func _ready() -> void:
	Main.position=$Player.position
	Main.current_scene_path="res://World/Levels/"+scene_name+".tscn"
	add_child(load("res://World/Resources/EnteringScene.tscn").instance())
	
	
