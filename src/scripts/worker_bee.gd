extends CharacterBody2D

const SPEED :float = 400.0

var target :Vector2 = Vector2.ZERO
var movement_direction :bool = true
var direction_away :bool = false
var stop :bool = true
var bee_ready :bool = true

@onready var cell: Sprite2D = $"../../../Cell"
@onready var collectible_cooldown: Timer = $CollectibleCooldown
@onready var path_follow_2d: PathFollow2D = $".."
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bee_path: Path2D = %BeePath
@onready var bee_hole: Sprite2D = $"../../../../../../Entities/BeeHole"
@onready var bee_sprite: Sprite2D = $"Bee Sprite"
@onready var progress_bar: TextureProgressBar = $"Bee Sprite/TextureProgressBar"
@onready var cell_cooldown: Timer = $CellCooldown
@onready var player_stats: Node = $"../../../../../../../Systems/PlayerStats"


## INITIALIZATION
func _ready() -> void:
	target = bee_hole.global_position
	global_position = cell.global_position
	#scale = Vector2(1, 1)
	collectible_cooldown.wait_time = player_stats.get_collectible_base_wait_time()
	
	#rotation = 0
	bee_path.rotate(get_angle_to(bee_hole.global_position))
	bee_path.curve.add_point(bee_path.to_local(target))




## MOVEMENT & PHYSICS
func _physics_process(delta: float) -> void:
	process_movement(delta)
	progress_bar.value = (cell_cooldown.time_left * 100) / cell_cooldown.wait_time
	

func process_movement(delta: float) -> void:
	if direction_away && !stop:
		#global_position = global_position.lerp(target, SPEED * delta)
		path_follow_2d.progress += SPEED * delta
	elif !direction_away && !stop:
		path_follow_2d.progress += -SPEED * delta
		#global_position = global_position.lerp(target, SPEED * delta)


func start_progress_bar() -> void:
	progress_bar.value = 100


func enter_bee_hole() -> void:
	animation_player.play("fade")
	stop = true
	collectible_cooldown.wait_time = player_stats.get_collectible_wait_time()
	collectible_cooldown.start()

func leave_cell() -> void:
	if bee_ready:
		bee_ready = false
		stop = false
		direction_away = true
		cell.clear()


### SIGNALS
###func _on_sight_area_body_entered(body: Node2D) -> void:
#	if body.name.begins_with("Collectible"):
#		enemies.append(body.global_position)
#
#func _on_sight_area_body_exited(_body: Node2D) -> void:
#	target = Vector2.ZERO
#
func _on_collection_area_body_entered(body: Node2D) -> void:
	if body.name == "BeeHole":
		#body.freeEntity()
		animation_player.play("fade")
		collectible_cooldown.start()
		

func _on_timer_timeout() -> void:
	animation_player.play("fadeBack")
	stop = false
	direction_away = false
	#bee_sprite.flip_h = false
	#target = cell.global_position
	
		

func _on_cell_cooldown_timeout() -> void:
	#direction_away = true
	bee_ready = true
	cell.ready_up()
	#bee_sprite.flip_h = true
	#target = bee_hole.global_position


func _on_collection_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Select"):
		leave_cell()
