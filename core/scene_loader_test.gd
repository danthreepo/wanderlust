extends Node

func _ready() -> void:
	print("Starting SceneLoader test...")
	await get_tree().create_timer(1.0).timeout
	SceneLoader.change_scene(
		"res://core/SceneLoaderTest2.tscn",
		"test_map",
		"test_spawn"
	)
