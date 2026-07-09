extends Control

@onready var collection_rate_debug_label: Label = $Panel/VBoxContainer/CollectionRateDebugLabel
@onready var cell_cooldown_debug_label: Label = $Panel/VBoxContainer/CellCooldownDebugLabel
@onready var player_stats: Node = %PlayerStats
@onready var economy: Node = %Economy

func _process(_delta: float) -> void:
	collection_rate_debug_label.text = str("Collection Rate: ", player_stats.get_collection_rate())
	cell_cooldown_debug_label.text = str("Cell Cooldown Time(sec): ", player_stats.get_total_wait_time())
