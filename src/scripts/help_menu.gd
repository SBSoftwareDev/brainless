extends Control

@onready var help_menu: Control = $"."
@onready var panel: Panel = $"../UIRoot/Panel"

func _ready() -> void:
	help_menu.size.x -= panel.size.x
	
func _on_button_pressed() -> void:
	help_menu.visible = false
