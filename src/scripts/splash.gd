extends Control

@onready var texture_rect: TextureRect = $TextureRect
@onready var idle_timer: Timer = $IdleTimer
@onready var fade_timer: Timer = $FadeTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.material.set_shader_parameter("fade_intensity", 0)
	idle_timer.start()
	
	#texture_rect.position.x -= get_parent().find_child("Panel").size.x / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !fade_timer.is_stopped():
		texture_rect.material.set_shader_parameter("fade_intensity", fade_timer.wait_time - fade_timer.time_left)

func _on_idle_timer_timeout() -> void:
	fade_timer.start()

func _on_fade_timer_timeout() -> void:
	queue_free()
