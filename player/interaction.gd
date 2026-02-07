extends Area2D

var nearby_npc: Node = null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	if nearby_npc and Input.is_action_just_pressed("interact"):
		nearby_npc.interact()

func _on_body_entered(body):
	if body.has_method("interact"):
		nearby_npc = body

func _on_body_exited(body):
	if body == nearby_npc:
		nearby_npc = null
