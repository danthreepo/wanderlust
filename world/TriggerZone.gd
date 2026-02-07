extends Node2D

@export var trigger_name: String = "example_trigger"

func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("Trigger activated:", trigger_name)
		emit_signal("triggered", trigger_name)

signal triggered(trigger_name: String)
