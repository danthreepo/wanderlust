extends Area2D

var nearby_interactable: Node = null

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.has_method("interact"):
		nearby_interactable = parent

func _on_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent == nearby_interactable:
		nearby_interactable = null
