extends Label

@onready var label: Label = $"."
@onready var player = get_tree().get_first_node_in_group("Players")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text = str(player.health)+"%"
