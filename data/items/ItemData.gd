extends Resource
class_name ItemData

@export var id: String
@export var display_name: String
@export_multiline var description: String
@export var icon: Texture2D

@export var stackable: bool = false
@export var max_stack: int = 1
