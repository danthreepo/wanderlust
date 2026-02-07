extends Node2D

@export var item: ItemData
@export var quantity: int = 1

var opened := false

func interact(player):
	if opened:
		return

	if player.inventory.add_item(item, quantity):
		opened = true
		print("chest opened")
		queue_free()
