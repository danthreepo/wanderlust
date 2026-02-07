extends CharacterBody2D

@export var move_speed: float = 50.0
@export var move_duration: float = 2.0
@export var pause_duration: float = 1.0

var timer: float = 0.0
var moving: bool = true
var is_interacting: bool = false

func _ready() -> void:
	randomize()
	_pick_random_direction()
	timer = move_duration

	if $NPCInteraction:
		$NPCInteraction.connect("triggered", Callable(self, "_on_interaction_triggered"))

func _physics_process(delta: float) -> void:
	if is_interacting:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	timer -= delta

	if moving:
		velocity = velocity.normalized() * move_speed
		move_and_slide()

		if get_slide_collision_count() > 0:
			_pick_random_direction()

		if timer <= 0.0:
			moving = false
			timer = pause_duration
	else:
		velocity = Vector2.ZERO
		move_and_slide()

		if timer <= 0.0:
			moving = true
			_pick_random_direction()
			timer = move_duration

func _pick_random_direction() -> void:
	var angle = randf() * TAU
	velocity = Vector2(cos(angle), sin(angle))

# ───────── Interaction ─────────

func _on_interaction_triggered(trigger_name: String, player: Node):
	on_interact()

func on_interact():
	pause_movement()
	print("NPC says: Hello!")

func pause_movement():
	is_interacting = true
	velocity = Vector2.ZERO

func resume_movement():
	is_interacting = false
	moving = true
	timer = move_duration
	_pick_random_direction()
