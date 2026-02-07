extends Node
class_name Inventory

signal inventory_changed

@export var size: int = 20

# ---------- SLOT DATA ----------
class Slot:
	var item: ItemData
	var quantity: int

# ---------- INVENTORY STATE ----------
var slots: Array = []

# ---------- LIFECYCLE ----------
func _ready():
	slots.resize(size)
	for i in size:
		slots[i] = null

# ---------- INVENTORY LOGIC ----------
func add_item(item: ItemData, amount := 1) -> bool:
	# Try stacking first
	if item.stackable:
		for slot in slots:
			if slot and slot.item == item and slot.quantity < item.max_stack:
				var addable = min(amount, item.max_stack - slot.quantity)
				slot.quantity += addable
				amount -= addable
				if amount == 0:
					inventory_changed.emit()
					return true

	# Find empty slot
	for i in slots.size():
		if slots[i] == null:
			var slot = Slot.new()
			slot.item = item
			slot.quantity = amount
			slots[i] = slot
			inventory_changed.emit()
			return true

	return false

# ---------- DEBUG (TEMPORARY) ----------
func debug_print():
	print("=== INVENTORY ===")
	for i in slots.size():
		if slots[i]:
			print(i, ": ", slots[i].item.display_name, " x", slots[i].quantity)
