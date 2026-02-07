extends CanvasLayer

signal scene_loaded(new_scene: Node)

var _is_loading: bool = false
var _fade_rect: ColorRect

func _ready() -> void:
	_create_fade_layer()

# =========================
# PUBLIC API
# =========================

func change_scene(
	scene_path: String,
	map_id: String = "",
	spawn_id: String = ""
) -> void:
	if _is_loading:
		return

	_is_loading = true

	if map_id != "":
		GameState.current_map_id = map_id
	if spawn_id != "":
		GameState.current_spawn_id = spawn_id

	await _fade_out()
	_perform_scene_change(scene_path)
	await _fade_in()

	_is_loading = false

# =========================
# INTERNAL
# =========================

func _perform_scene_change(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	get_tree().root.add_child(new_scene)

	if get_tree().current_scene:
		get_tree().current_scene.queue_free()

	get_tree().current_scene = new_scene
	emit_signal("scene_loaded", new_scene)

# =========================
# FADE LOGIC
# =========================

func _create_fade_layer() -> void:
	_fade_rect = ColorRect.new()
	_fade_rect.color = Color.BLACK
	_fade_rect.size = get_viewport().get_visible_rect().size
	_fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_fade_rect.modulate.a = 0.0
	add_child(_fade_rect)

func _fade_out() -> void:
	await _fade_to(1.0)

func _fade_in() -> void:
	await _fade_to(0.0)

func _fade_to(target_alpha: float) -> void:
	var tween = create_tween()
	tween.tween_property(_fade_rect, "modulate:a", target_alpha, 0.3)
	await tween.finished
