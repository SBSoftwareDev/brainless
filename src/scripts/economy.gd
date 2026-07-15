extends Node

var nectar :int = 1000
var bees :int = 0

var cell_price = 4
var price_multiplier :float = 3
var cells_purchased :int = 0

var cell_cooldown_price :int = 5
var cell_cooldown_rate_purchases :int = 0
var collection_price :int = 5
var collection_rate_purchases :int = 0

var speed_upgrade_purchases :int = 0
var speed_price :int = 5

var mega_upgrade_price :int = 1000
var mega_upgrade_purchases :int = 0

@onready var level: Node2D = $"../../World/Level"

func _ready() -> void:
	bees = level.find_children("BeeAnd*").size()

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
	
func getCollectiblePrice() -> int:
	return ceil(speed_price + (speed_upgrade_purchases * price_multiplier))
	
func getMegaUpgradePrice() -> int:
	return ceil(mega_upgrade_price + (mega_upgrade_purchases * price_multiplier)) 

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
		
func buySpeedUpgrade() -> bool:
	var price :int = getCollectiblePrice()
	if nectar >= price:
		nectar -= price
		speed_upgrade_purchases += 1
		return true
	else:
		return false


func buyMegaUpgrade() -> bool:
	var price :int = getMegaUpgradePrice()
	if nectar >= price:
		nectar -= price
		mega_upgrade_purchases += 1
		return true
	else:
		return false
