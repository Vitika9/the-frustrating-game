extends RigidBody2D
class_name Bomb

onready var animatedSprite=$AnimatedSprite

func _ready() -> void:
	animatedSprite.animation="Animate"
	animatedSprite.playing=true

func _on_Area2D_body_entered(body: Node) -> void:
	if(body is Player or animatedSprite.animation!="Explode"):
		animatedSprite.animation="Explode"
		$AudioStreamPlayer2D.playing=true
		animatedSprite.connect("animation_finished",self,"_on_AnimatedSprite_animation_finished")
		animatedSprite.frame=0
		
		yield(get_tree().create_timer(.5),"timeout")
		if body is TileMap:
			var tile_pos=body.world_to_map(position)
			tile_pos.y+=1
			var id=body.get_cell(tile_pos.x,tile_pos.y)
			
			if(body.tile_set.tile_get_name(id).substr(0,9)=="Breakable"):
				body.set_cellv(tile_pos,-1)
				body.set_cellv(Vector2(tile_pos.x+1,tile_pos.y-1),-1)
				body.set_cellv(Vector2(tile_pos.x-1,tile_pos.y-1),-1)
				body.set_cellv(Vector2(tile_pos.x+1,tile_pos.y),-1)
				body.set_cellv(Vector2(tile_pos.x-1,tile_pos.y),-1)
		elif body is Player:
			body.queue_free()


func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()
	

