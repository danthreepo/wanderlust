extends Node2D

@export var trigger_name: String = "dialogue_trigger"

signal triggered(trigger_name: String, player: Node)

var can_interact: bool = false
var player_ref: Node = null

func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		can_interact = true
		player_ref = body

func _on_body_exited(body: Node) -> void:
	if body == player_ref:
		can_interact = false
		player_ref = null

func _process(delta: float) -> void:
	if can_interact and Input.is_action_just_pressed("interact") and player_ref:
		print("Dialogue activated:", trigger_name)
		emit_signal("triggered", trigger_name, player_ref)
