extends Node

var nectar :int = 100
var bees :int = 0

var cell_price = 4
var price_multiplier :float = 2.75
var cells_purchased :int = 0

var cell_cooldown_price :int = 5
var cell_cooldown_rate_purchases :int = 0
var collection_price :int = 5
var collection_rate_purchases :int = 0

@onready var entities: Node2D = $"../../World/Entities"

func _ready() -> void:
	bees = entities.find_children("BeeAnd*", "", false).size()

func addNectar(value :int) -> int:
	nectar += value
	return nectar
	
func getNectarAmount() -> int:
	return nectar
	
func getBeeAmount() -> int:
	return bees
	
func getCellPrice() -> int:
	return ceil(cell_price + (cells_purchased * price_multiplier))
	
func getCellCooldownPrice() -> int:
	return ceil(cell_cooldown_price + (cell_cooldown_rate_purchases * price_multiplier))
	
func getCollectionPrice() -> int:
	return ceil(collection_price + (collection_rate_purchases * price_multiplier))

func buyCell() -> bool:
	var price :int = getCellPrice()
	if nectar >= price:
		nectar -= price
		cells_purchased += 1
		bees += 1
		return true
	else:
		return false
		
func buyCellCooldownUpgrade() -> bool:
	var price :int = getCellCooldownPrice()
	if nectar >= price:
		nectar -= price
		cell_cooldown_rate_purchases += 1
		return true
	else:
		return false

func buyCollectionUpgrade() -> bool:
	var price :int = getCollectionPrice()
	if nectar >= price:
		nectar -= price
		collection_rate_purchases += 1
		return true
	else:
		return false
