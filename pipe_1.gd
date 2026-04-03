extends Node2D

@export var pipe_texture: Texture2D
@onready var sprite: Sprite2D = $IndustrialTile45

var player_inside = false
var player_ref
@export var exit_pipe: NodePath
@onready var exit: Marker2D = $Marker2D


func _ready() -> void:
	if pipe_texture:
		sprite.texture = pipe_texture

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		player_inside = true
		player_ref = body



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Players"):
		player_inside = false


func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("down"):
		var pipe = get_node(exit_pipe)
		player_ref.global_position = pipe.exit.global_position
