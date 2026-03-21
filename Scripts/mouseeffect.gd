extends Sprite2D
@onready var play: TextureButton = $"../Play"
@onready var settings: TextureButton = $"../Settings"
@onready var credits: TextureButton = $"../Credits"

var mouse_pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	self.position = mouse_pos
	var rect = play.get_global_rect()
	var set_rect = settings.get_global_rect()
	var credits_rect = credits.get_global_rect()
	if rect.has_point(mouse_pos) or set_rect.has_point(mouse_pos) or credits_rect.has_point(mouse_pos):
		self.texture = load("res://Sci-Fi UI Game Asset Pack/green assets/hud/target-1.png")
	else:
		self.texture = load("res://Sci-Fi UI Game Asset Pack/green assets/hud/target-3.png")
