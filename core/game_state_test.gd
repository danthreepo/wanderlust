extends Node

func _ready() -> void:
	print("--- GAME STATE TEST ---")

	GameState.set_story_flag("met_king")
	print("Met king:", GameState.get_story_flag("met_king"))

	GameState.add_key_item("airship_pass")
	print("Has airship pass:", GameState.has_key_item("airship_pass"))

	GameState.set_world_state("chest_001_opened", true)
	print("Chest opened:", GameState.get_world_state("chest_001_opened"))

	GameState.reset_game_state()
	print("After reset, met king:", GameState.get_story_flag("met_king"))
