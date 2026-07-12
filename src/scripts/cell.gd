extends Sprite2D

@onready var player_stats: Node = $"../../../../../Systems/PlayerStats"
@onready var economy: Node = $"../../../../../Systems/Economy"
@onready var cell_cooldown: Timer = $"../BeePath/PathFollow2D/Worker Bee/CellCooldown"
@onready var worker_bee: CharacterBody2D = $"../BeePath/PathFollow2D/Worker Bee"
@onready var ready_cell: Sprite2D = $ReadyCell
@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var path_follow_2d: PathFollow2D = $"../BeePath/PathFollow2D"

var bee_inside :bool = true

func _ready() -> void:
	cell_cooldown.wait_time = player_stats.get_base_wait_time()
	
func _process(_delta: float) -> void:
	progress_bar.value = (cell_cooldown.time_left * 100) / cell_cooldown.wait_time
	
	if cell_cooldown.wait_time <= 0:
		cell_cooldown.wait_time = 0.0001

func ready_up() -> void:
	ready_cell.visible = true


func clear() -> void:
	ready_cell.visible = false

func start_progress_bar() -> void:
	progress_bar.value = 100

func _on_area_2d_body_entered(body: Node2D) -> void:
	var parent :Node2D = body.get_parent().get_parent().get_parent()
	if parent && parent == get_parent() && bee_inside == false:
		bee_inside = true
		#path_follow_2d.rotates = false
		economy.addNectar(player_stats.get_collection_rate())
		cell_cooldown.wait_time = player_stats.get_total_wait_time()
		cell_cooldown.start()
		start_progress_bar()
		
		#worker_bee.rotation = 0


func _on_area_2d_body_exited(_body: Node2D) -> void:
	bee_inside = false
	#path_follow_2d.rotates = true
