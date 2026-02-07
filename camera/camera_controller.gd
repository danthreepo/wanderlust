extends Camera2D

@export var target: NodePath          # Node to follow
@export var smoothing_speed: float = 5.0
@export var look_ahead_distance: Vector2 = Vector2(50, 30)
@export var world_tilemap: NodePath   # Optional: assign your TileMap for automatic limits

var _target_node: Node2D
var _tilemap: TileMap
var _min_limit: Vector2
var _max_limit: Vector2

func _ready():
	if target:
		_target_node = get_node(target)
	make_current()  # activate this camera

	if world_tilemap:
		_tilemap = get_node(world_tilemap)
		_calculate_limits()

func _process(delta):
	if not _target_node:
		return
	
	var desired_position = _target_node.global_position

	# Look-ahead
	if _target_node.has_method("get_velocity"):
		var velocity = _target_node.get_velocity()
		desired_position += Vector2(sign(velocity.x) * look_ahead_distance.x,
									sign(velocity.y) * look_ahead_distance.y)
	
	# Smooth follow
	var new_position = global_position.lerp(desired_position, smoothing_speed * delta)

	# Clamp to level bounds if TileMap exists
	if _tilemap:
		new_position.x = clamp(new_position.x, _min_limit.x, _max_limit.x)
		new_position.y = clamp(new_position.y, _min_limit.y, _max_limit.y)

	global_position = new_position

func _calculate_limits():
	# Get the TileMap bounds in global coordinates
	var rect = _tilemap.get_used_rect()
	var cell_size = _tilemap.cell_size

	_min_limit = _tilemap.to_global(rect.position * cell_size)
	_max_limit = _tilemap.to_global((rect.position + rect.size) * cell_size) - get_viewport_rect().size
