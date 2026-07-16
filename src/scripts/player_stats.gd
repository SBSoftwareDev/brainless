extends Node

var collection_rate :float = 1.0
var cell_cooldown_rate :float = 1.0

var collectible_cooldown_base_time :float = 5.0
var cell_cooldown_base_time :float = 5.0

var collectible_cooldown_wait_time :float

var collection_rate_upgrades :int = 0
var cell_cooldown_rate_upgrades :int = 0

func get_collection_rate() -> float: return collection_rate
func get_cell_cooldown_rate() -> float: return cell_cooldown_rate
func get_collectible_wait_time() -> float: return collectible_cooldown_wait_time
func get_collectible_base_wait_time() -> float: return collectible_cooldown_base_time

func get_base_wait_time() -> float: return cell_cooldown_base_time
func get_total_wait_time() -> float: return cell_cooldown_base_time * cell_cooldown_rate

func _ready() -> void:
	collectible_cooldown_wait_time = collectible_cooldown_base_time
	
func upgrade_collection_rate(multiplier :float = 1.25) -> String:
	collection_rate *= multiplier
	return str("%0.2f" % collection_rate)
	
func upgrade_cell_cooldown_rate() -> String:
	cell_cooldown_rate -= 0.1
	return str("%0.2f" % cell_cooldown_rate)
	
func upgrade_collectible_wait_time() -> String:
	collectible_cooldown_wait_time -= 0.1
	return str("%0.2f" % collectible_cooldown_wait_time)

func get_collectible_cooldown_wait_time() -> float:
	return collectible_cooldown_wait_time
