extends Control

@onready var economy: Node = $"../../../Systems/Economy"
@onready var rich_text_label: RichTextLabel = $PanelContainer/MarginContainer/RichTextLabel
@onready var panel_container: PanelContainer = $PanelContainer

func _ready() -> void:
	panel_container.global_position.y -= panel_container.size.y

func _process(_delta: float) -> void:
	rich_text_label.text = str("Price: ", economy.getCellPrice(), " [img]res://assets/img/ui/nectar.png[/img]")
