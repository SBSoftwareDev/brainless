extends Node

var collection_rate :float = 1.0
var cell_cooldown_rate :float = 1.0
var cell_cooldown_base_time :float = 4.0

var collection_rate_upgrades :int = 0
var cell_cooldown_rate_upgrades :int = 0

func get_collection_rate() -> float: return collection_rate
func get_cell_cooldown_rate() -> float: return cell_cooldown_rate
func get_base_wait_time() -> float: return cell_cooldown_base_time
func get_total_wait_time() -> float: return cell_cooldown_base_time * cell_cooldown_rate


func upgrade_collection_rate() -> String:
	collection_rate *= 2
	return str("%0.2f" % collection_rate)
	
func upgrade_cell_cooldown_rate() -> String:
	cell_cooldown_rate -= 0.1
	return str("%0.2f" % cell_cooldown_rate)
