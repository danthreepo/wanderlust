extends Node
class_name PlayerStateController

signal state_changed(old_state, new_state)

enum PlayerState {
	FREE,
	INTERACTING,
	DIALOGUE,
	CUTSCENE,
	MENU
}

var current_state: PlayerState = PlayerState.FREE


# -------------------------
# State Queries (Player uses these)
# -------------------------

func can_move() -> bool:
	return current_state == PlayerState.FREE


func can_interact() -> bool:
	return current_state == PlayerState.FREE


func can_open_menu() -> bool:
	return current_state == PlayerState.FREE


# -------------------------
# State Transitions (Other systems call these)
# -------------------------

func enter_free():
	_set_state(PlayerState.FREE)


func enter_interaction():
	_set_state(PlayerState.INTERACTING)


func enter_dialogue():
	_set_state(PlayerState.DIALOGUE)


func enter_cutscene():
	_set_state(PlayerState.CUTSCENE)


func enter_menu():
	_set_state(PlayerState.MENU)


# -------------------------
# Internal
# -------------------------

func _set_state(new_state: PlayerState) -> void:
	if current_state == new_state:
		return

	var old_state = current_state
	current_state = new_state
	emit_signal("state_changed", old_state, new_state)
