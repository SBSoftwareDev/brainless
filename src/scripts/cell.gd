extends Sprite2D

@onready var player_stats: Node = $"../../../../Systems/PlayerStats"
@onready var economy: Node = $"../../../../Systems/Economy"
@onready var cell_cooldown: Timer = $"../Worker Bee/CellCooldown"

var bee_inside :bool = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_parent() == get_parent() && bee_inside == false:
		bee_inside = true
		economy.addNectar(player_stats.get_collection_rate())
		cell_cooldown.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	bee_inside = false
	if body.get_parent() == get_parent():
		cell_cooldown.start()
