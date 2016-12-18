extends RigidBody2D

const BRICK2D = preload("res://addons/custom_nodes/brick2d/brick2d.gd")
const INITIAL_BALL_SPEED = 250
const MAX_BALL_SPEED = 600

var paddle
var sample_player
var bricks_node

func _ready():
	set_fixed_process(true);
	paddle = get_node("/root/World/Paddle")
	sample_player = get_node("/root/World/SamplePlayer")
	bricks_node = get_node("/root/World/Bricks")

func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body extends BRICK2D:
			handle_ball_brick_collision(body)
		elif body.get_name() == "Paddle":
			handle_ball_paddle_collision(body)
		elif body.get_name() == "Walls":
			handle_ball_wall_collision()
		limit_velocity()
	check_missed_ball()

func check_missed_ball():
	if get_pos().y > get_viewport_rect().end.y:
		handle_missed_ball()
		create_new_ball()

func create_new_ball():
	var paddle = get_tree().get_root().get_node("/root/World/Paddle")
	paddle.create_ball()

func handle_missed_ball():
	sample_player.play("ball_missed")
	queue_free()

func handle_ball_brick_collision(brick):
	brick.on_hit()
	on_hit()
	if bricks_node.get_child_count() == 1:
		sample_player.play("applause")

func on_hit():
	get_node("Sprite/Animation").play("ball-hit")
	
func handle_ball_paddle_collision(body):
	var speed = get_linear_velocity().length()
	var ancor_pos = body.get_node("Ancor").get_global_pos()
	var direction = get_pos() - ancor_pos
	var paddle = get_node("/root/World/Paddle")
	# Fix direction if ball is underneath the paddle
	if get_pos().y > paddle.get_global_pos().y:
		direction.y = - direction.y
	var velocity = direction.normalized() * min(speed, MAX_BALL_SPEED)
	set_linear_velocity(velocity)
	paddle.on_hit()
	on_hit()

func handle_ball_wall_collision():
	sample_player.play("ball_hits_wall")

func limit_velocity():
	var speed = get_linear_velocity().length()
	if speed > MAX_BALL_SPEED:
		var max_velocity = get_linear_velocity().normalized() * MAX_BALL_SPEED
		set_linear_velocity(max_velocity)

func get_random_velocity():
	randomize()
	var angle = rand_range(PI / 4, 3 * PI / 4);
	return Vector2(INITIAL_BALL_SPEED, 0).rotated(angle)

func fire_ball():
	set_linear_velocity(get_random_velocity())