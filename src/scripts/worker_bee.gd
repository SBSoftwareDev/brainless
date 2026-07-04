extends CharacterBody2D

const SPEED :float = 1.0

var target :Vector2 = Vector2.ZERO
var movement_direction :bool = true

@onready var cell: Sprite2D = $"../Cell"
@onready var collectible_cooldown: Timer = $CollectibleCooldown
@onready var cell_cooldown: Timer = $CellCooldown
@onready var collectible: CharacterBody2D = $"../../Collectible"
@onready var economy: Node = $"../../../../Systems/Economy"

## INITIALIZATION
func _ready() -> void:
	target = collectible.global_position





## MOVEMENT & PHYSICS
func _physics_process(delta: float) -> void:
	process_movement(delta)

func process_movement(delta: float) -> void:
	global_position = global_position.lerp(target, SPEED * delta)






### SIGNALS
###func _on_sight_area_body_entered(body: Node2D) -> void:
#	if body.name.begins_with("Collectible"):
#		enemies.append(body.global_position)
#
#func _on_sight_area_body_exited(_body: Node2D) -> void:
#	target = Vector2.ZERO
#
func _on_collection_area_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Collectible"):
		#body.freeEntity()
		print("Collected ", economy.addNectar(1))
		collectible_cooldown.start()

func _on_timer_timeout() -> void:
	print("Omw son")
	target = cell.global_position
