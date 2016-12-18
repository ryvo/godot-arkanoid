tool
extends StaticBody2D

func _ready():
# var shape = BoxShape.new()
# shape.set_extents(Vector2(37,21));
# var collision = CollisionShape2D.new()
# collision.set_shape(shape)
# add_child(collision)
    pass

func on_hit():
	get_node("/root/World/SamplePlayer").play("ball_hits_brick")
	get_node("Sprite/Animation").play("brick-hit")
	get_node("Collision").queue_free()

func _on_Animation_finished():
	queue_free()