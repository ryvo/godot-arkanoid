extends Node2D

func _ready():
	var paddle = get_node("Paddle")
	paddle.on_main_scene_ready()