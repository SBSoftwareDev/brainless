extends Sprite2D

@onready var player_stats: Node = $"../../../../Systems/PlayerStats"
@onready var economy: Node = $"../../../../Systems/Economy"
@onready var cell_cooldown: Timer = $"../BeePath/PathFollow2D/Worker Bee/CellCooldown"
@onready var worker_bee: CharacterBody2D = $"../BeePath/PathFollow2D/Worker Bee"
@onready var ready_cell: Sprite2D = $ReadyCell

var bee_inside :bool = true

func _ready() -> void:
	cell_cooldown.wait_time = player_stats.get_base_wait_time()
	
func _process(_delta: float) -> void:
	if cell_cooldown.wait_time <= 0:
		cell_cooldown.wait_time = 0.0001

func ready_up() -> void:
	ready_cell.visible = true


func clear() -> void:
	ready_cell.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	var parent :Node2D = body.get_parent().get_parent().get_parent()
	if parent && parent == get_parent() && bee_inside == false:
		bee_inside = true
		economy.addNectar(player_stats.get_collection_rate())
		cell_cooldown.wait_time = player_stats.get_total_wait_time()
		cell_cooldown.start()
		worker_bee.start_progress_bar()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	bee_inside = false
