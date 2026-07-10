extends CharacterBody2D

const SPEED :float = 400.0

var target :Vector2 = Vector2.ZERO
var movement_direction :bool = true
var collectible_cooldown_wait_time :float = 2.0
var direction_away :bool = true

@onready var cell: Sprite2D = $"../../../Cell"
@onready var collectible_cooldown: Timer = $CollectibleCooldown
@onready var collectible: CharacterBody2D = $"../../../../Collectible"
@onready var economy: Node = $"../../../../../../Systems/Economy"
@onready var path_follow_2d: PathFollow2D = $".."
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bee_path: Path2D = %BeePath
@onready var bee_hole: Sprite2D = $"../../../../BeeHole"
@onready var bee_sprite: Sprite2D = $"Bee Sprite"

## INITIALIZATION
func _ready() -> void:
	target = bee_hole.global_position
	global_position = cell.global_position
	bee_path.curve.add_point(bee_path.to_local(target))
	scale = Vector2(1, 1)




## MOVEMENT & PHYSICS
func _physics_process(delta: float) -> void:
	process_movement(delta)
	

func process_movement(delta: float) -> void:
	if direction_away:
		#global_position = global_position.lerp(target, SPEED * delta)
		path_follow_2d.progress += SPEED * delta
	else:
		path_follow_2d.progress += -SPEED * delta
		#global_position = global_position.lerp(target, SPEED * delta)





func enter_bee_hole() -> void:
	animation_player.play("fade")
	collectible_cooldown.start()


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
	direction_away = false
	bee_sprite.flip_h = false
	#target = cell.global_position
	
		

func _on_cell_cooldown_timeout() -> void:
	direction_away = true
	bee_sprite.flip_h = true
	target = bee_hole.global_position
