extends Area2D

func _on_Flag_body_entered(body: Node) -> void:
		Main.position=body.global_position
		get_node("../../").add_child(load("res://Ui/CheckPointNotification.tscn").instance())
