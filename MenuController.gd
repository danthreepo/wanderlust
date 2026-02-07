extends CanvasLayer
class_name MenuController

@export var player: Node

@onready var state_controller: PlayerStateController = player.get_node("PlayerStateController")
@onready var background_dim: ColorRect = $BackgroundDim


var is_open := false


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

func _process(_delta):
	# Toggle menu
	if Input.is_action_just_pressed("menu"):
		if is_open:
			close_menu()
		else:
			open_menu()


func open_menu():
	if is_open:
		return

	is_open = true
	visible = true
	background_dim.visible = true   # show dim
	state_controller.enter_menu()
	get_tree().paused = true


func close_menu():
	if not is_open:
		return

	is_open = false
	visible = false
	background_dim.visible = false  # hide dim
	get_tree().paused = false
	state_controller.enter_free()
