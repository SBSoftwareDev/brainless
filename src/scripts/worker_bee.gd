extends CharacterBody2D

const SPEED :float = 2.0

var target :Vector2 = Vector2.ZERO
var enemies :Array[Vector2]

@onready var economy: Node = $"Economy"


## MOVEMENT & PHYSICS
func _physics_process(delta: float) -> void:
	process_movement(delta)

func process_movement(delta: float) -> void:
	if !enemies.is_empty():
		target = enemies[0]
		position = position.lerp(target, SPEED * delta)
	
	move_and_slide()






## SIGNALS
func _on_sight_area_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Collectible"):
		enemies.append(body.global_position)

func _on_sight_area_body_exited(_body: Node2D) -> void:
	target = Vector2.ZERO

func _on_collection_area_body_entered(body: Node2D) -> void:
	if body.name.begins_with("Collectible"):
		economy.nectar += 1
		body.freeEntity()
		print("Collected ", enemies.pop_front())
