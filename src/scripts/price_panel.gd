extends Control

@onready var economy: Node = $"../../../Systems/Economy"
@onready var rich_text_label: RichTextLabel = $Panel/RichTextLabel

func _process(_delta: float) -> void:
	rich_text_label.text = str("Price: ", economy.getCellPrice(), " [img]res://assets/img/ui/nectar.png[/img]")
