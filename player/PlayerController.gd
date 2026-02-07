extends CharacterBody2D

@export var move_speed := 120.0

@onready var state_controller: PlayerStateController = $PlayerStateController
@onready var inventory: Inventory = $Inventory
@onready var interaction_area = $InteractionArea



func _physics_process(delta):
	handle_movement(delta)
	handle_interaction() # 👈 ADD THIS


func handle_movement(delta):
	# 🔒 STATE GATE
	if not state_controller.can_move():
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = input_vector * move_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()


# -------------------------
# INTERACTION (OPTION B)
# -------------------------
func handle_interaction():
	if Input.is_action_just_pressed("interact"):
		if interaction_area.nearby_interactable:
			interaction_area.nearby_interactable.interact(self)
