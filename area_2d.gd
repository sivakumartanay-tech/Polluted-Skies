extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Players"):
		return

	if get_tree().current_scene.scene_file_path == "res://Scenes/level_0.tscn":
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	elif get_tree().current_scene.scene_file_path == "res://Scenes/level_1.tscn":
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
