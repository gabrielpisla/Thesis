extends KinematicBody2D

var PlayerStats = ResourceLoader.PlayerStats
var MainInstances = ResourceLoader.MainInstances

export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 64
export (float) var FRICTION = 0.25

var motion = Vector2.ZERO
var input_vector_hist = Vector2.ZERO

onready var sprite = $Sprite
onready var spriteAnimator = $SpriteAnimator

signal hit_door(door)

func _ready():
	MainInstances.Player = self

func _exit_tree():
	MainInstances.Player = null

func _physics_process(delta):
	move(delta)


func move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		input_vector_hist = input_vector
		motion += input_vector * ACCELERATION * delta
		motion = motion.clamped(MAX_SPEED)
	else:
		motion = motion.linear_interpolate(Vector2.ZERO, FRICTION)
		
	update_animation(input_vector)
	move_and_collide(motion * delta)

func update_animation(input_vector):
	if input_vector != Vector2.ZERO:
		if input_vector.x == 0 and input_vector.y != 0:
			if input_vector.y < 0:
				spriteAnimator.play("Walk (Back)")
			elif input_vector.y > 0:
				spriteAnimator.play("Walk (Front)")
		elif input_vector.x != 0:
			sprite.scale.x = sign(input_vector.x) * 0.724
			spriteAnimator.play("Walk (Right)")
	else:
		if input_vector_hist.x > 0:
			spriteAnimator.play("Idle (Right)")
		elif input_vector_hist.x < 0:
			spriteAnimator.play("Idle (Right)")
		elif input_vector_hist.y > 0:
			spriteAnimator.play("Idle (Front)")
		elif input_vector_hist.y < 0:
			spriteAnimator.play("Idle (Back)")
