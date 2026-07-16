extends Control

@onready var help_menu: Control = $"."

func _on_button_pressed() -> void:
	help_menu.visible = false
