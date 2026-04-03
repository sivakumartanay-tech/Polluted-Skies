extends Sprite2D

@onready var home: TextureButton = $"../TextureButton"

var mouse_pos
@onready var sound: TextureButton = $"../TextureButton2"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	self.position = mouse_pos
	var rect = sound.get_global_rect()
	var home_rect = home.get_global_rect()
	
	if rect.has_point(mouse_pos) or home_rect.has_point(mouse_pos):
		self.texture = load("res://Sci-Fi UI Game Asset Pack/green assets/hud/target-1.png")
	else:
		self.texture = load("res://Sci-Fi UI Game Asset Pack/green assets/hud/target-3.png")
