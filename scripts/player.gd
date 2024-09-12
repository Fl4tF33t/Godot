class_name Player

extends CharacterBody2D

const SPEED = 130.0
const ROLL_SPEED = 175.0
const ROLL_DURATION = 0.5
const JUMP_VELOCITY = -300.0
const DOUBLE_JUMP_VELOCITY = -200.0

var is_double_jump = true
var is_rolling = false
var roll_timer = 0.0
var is_on_ladder = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_audio: PlayerAudio = $AudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not is_on_ladder:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or is_on_ladder:
			is_double_jump = false
			is_on_ladder = false
			velocity.y = JUMP_VELOCITY
			player_audio._play_sound(PlayerAudio.Sound.Jump)
		elif not is_double_jump and not is_on_ladder:
			is_double_jump = true
			velocity.y = DOUBLE_JUMP_VELOCITY
			player_audio._play_sound(PlayerAudio.Sound.Jump)

	# Handle Movement
	var direction := Input.get_axis("move_left", "move_right")
	if not is_rolling:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var up_down := Input.get_axis("move_up", "move_down")
	if is_on_ladder:
		is_double_jump = false
		if up_down:
			velocity.y = up_down * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

	# Handle roll.
	if Input.is_action_just_pressed("roll") and direction != 0 and is_on_floor() and not is_rolling:
		print("roll")
		is_rolling = true
		roll_timer = ROLL_DURATION
		velocity.x = direction * ROLL_SPEED
		player_audio._play_sound(PlayerAudio.Sound.Roll)

	# If rolling, count down the timer and stop rolling when done
	if is_rolling:
		roll_timer -= delta
		if roll_timer <= 0:
			is_rolling = false

	# Animations
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

		# Play the animation
	if not is_rolling:
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("idle")
			else: 
				animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("jump")
	else:
		animated_sprite_2d.play("roll")

	move_and_slide()
