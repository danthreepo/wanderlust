extends CharacterBody2D

@export var move_speed: float = 50.0
@export var move_duration: float = 2.0   # seconds moving in one direction
@export var pause_duration: float = 1.0  # seconds to pause

var timer: float = 0.0
var moving: bool = true

func _ready():
	_pick_random_direction()
	timer = move_duration

func _physics_process(delta: float) -> void:
	timer -= delta

	if moving:
		# Move NPC
		velocity = velocity.normalized() * move_speed
		move_and_slide()

		# If collided, pick a new random direction
		if get_slide_collision_count() > 0:
			_pick_random_direction()

		if timer <= 0.0:
			moving = false
			timer = pause_duration
	else:
		# Pausing
		velocity = Vector2.ZERO
		if timer <= 0.0:
			moving = true
			_pick_random_direction()
			timer = move_duration

func _pick_random_direction():
	var angle = randf() * PI * 2
	velocity = Vector2(cos(angle), sin(angle))
