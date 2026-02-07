extends Node

# =========================
# CORE GAME STATE
# =========================

# Current location
var current_map_id: String = ""
var current_spawn_id: String = ""

# Player progression
var story_flags: Dictionary = {}
var key_items: Dictionary = {}

# World state
var world_state: Dictionary = {}

# =========================
# INITIALIZATION
# =========================

func _ready() -> void:
	_initialize_defaults()

func _initialize_defaults() -> void:
	current_map_id = "overworld_start"
	current_spawn_id = "default"

	story_flags.clear()
	key_items.clear()
	world_state.clear()

# =========================
# STORY FLAGS
# =========================

func set_story_flag(flag_name: String, value: bool = true) -> void:
	story_flags[flag_name] = value

func get_story_flag(flag_name: String) -> bool:
	return story_flags.get(flag_name, false)

# =========================
# KEY ITEMS
# =========================

func add_key_item(item_id: String) -> void:
	key_items[item_id] = true

func has_key_item(item_id: String) -> bool:
	return key_items.get(item_id, false)

# =========================
# WORLD STATE
# =========================

func set_world_state(key: String, value) -> void:
	world_state[key] = value

func get_world_state(key: String, default_value = null):
	return world_state.get(key, default_value)

# =========================
# DEBUG / RESET
# =========================

func reset_game_state() -> void:
	_initialize_defaults()
