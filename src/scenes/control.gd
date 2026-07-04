extends Control

@onready var economy: Node = %Economy
@onready var nectar_amount_label: RichTextLabel = $ColorRect/VBoxContainer/HBoxContainer/NectarAmountLabel
@onready var bee_amount_label: RichTextLabel = $ColorRect/VBoxContainer/HBoxContainer/BeeAmountLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	nectar_amount_label.text = str("Nectar: ", economy.getNectarAmount())
	bee_amount_label.text = str("Bees: ", economy.getBeeAmount())
