extends KinematicBody2D

const BALL_SCENE = preload("res://scenes/pseudo/ball_scene.tscn")
const PADDLE_BALL_DISTANCE = 64

var ball
var ball_fired = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	var y = get_pos().y
	var mouse_x = get_viewport().get_mouse_pos().x
	set_pos(Vector2(mouse_x, y))
	if !ball_fired:
		ball.set_pos(get_pos() - Vector2(0, PADDLE_BALL_DISTANCE))

func on_main_scene_ready():
	create_ball()

func on_hit():
	get_node("/root/World/SamplePlayer").play("ball_hits_paddle")
	get_node("/root/World/Paddle/Sprite/Animation").play("platform-hit")

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		ball.fire_ball()
		ball_fired = true

func create_ball():
	ball_fired = false
	ball = BALL_SCENE.instance()
	ball.set_pos(get_pos() - Vector2(0, PADDLE_BALL_DISTANCE))
	var parent = get_tree().get_root().get_node("World")
	parent.add_child(ball)
