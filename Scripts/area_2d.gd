extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_tree().get_nodes_in_group("enemies").size() == 0:
		$".".monitoring = true


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		get_tree().reload_current_scene()
