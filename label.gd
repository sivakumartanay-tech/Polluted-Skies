extends Label
@onready var label: Label = $"."
@onready var player: CharacterBody2D = $"../../../../Player 1"



func _process(_delta: float) -> void:
	label.text = str(Global.money)
	
