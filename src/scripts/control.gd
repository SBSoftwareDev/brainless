extends Control


@onready var player_stats: Node = %PlayerStats
@onready var economy: Node = %Economy
@onready var nectar_amount_label: RichTextLabel = %NectarAmountLabel
@onready var bee_amount_label: RichTextLabel = %BeeAmountLabel
@onready var price_panel: Control = $PricePanel
@onready var cell_cooldown_label: RichTextLabel = $Panel/VBoxContainer/CellCooldownUpgradePanel3/Panel/MarginContainer/HBox2/VBoxContainer/Label2
@onready var rate_upgrade_label: RichTextLabel = $"Panel/VBoxContainer/RateUpgradePanel/Panel/MarginContainer/HBox/VBoxContainer/Label2"
@onready var rate_upgrade_button: Button = $Panel/VBoxContainer/RateUpgradePanel/Panel/MarginContainer/HBox/RateUpgradeButton
@onready var cell_upgrade_button: Button = $Panel/VBoxContainer/CellCooldownUpgradePanel3/Panel/MarginContainer/HBox2/CellUpgradeButton
@onready var speed_upgrade_label: RichTextLabel = $Panel/VBoxContainer/SpeedUpgradePanel/Panel/MarginContainer/HBox2/VBoxContainer/Label2
@onready var rate_cost_label: RichTextLabel = $Panel/VBoxContainer/RateUpgradePanel/Panel/MarginContainer/HBox/VBoxContainer/CostLabel
@onready var speed_cost_label: RichTextLabel = $Panel/VBoxContainer/SpeedUpgradePanel/Panel/MarginContainer/HBox2/VBoxContainer/CostLabel
@onready var cell_cost_label: RichTextLabel = $Panel/VBoxContainer/CellCooldownUpgradePanel3/Panel/MarginContainer/HBox2/VBoxContainer/CostLabel

@onready var hive_button: Button = $"Panel/VBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer/Hive Bridge Button"
@onready var royal_jelly_button: Button = $"Panel/VBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer/Royal Jelly Button"
@onready var mega_flora_button: Button = $"Panel/VBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer3/Mega Flora Button"
@onready var triple_cells_button: Button = $"Panel/VBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer3/Triple Cells Button"

@onready var help_menu: Control = $"../HelpMenu"



func _ready() -> void:
	nectar_amount_label.text = str("[img]res://assets/img/ui/nectar.png[/img] 0")
	bee_amount_label.text = str("[img]res://assets/img/worker/Bee_Head.png[/img] 0")
	
	#Cost labels
	rate_cost_label.text = str("Cost: ", economy.getCollectionPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
	speed_cost_label.text = str("Cost: ", economy.getCollectiblePrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
	cell_cost_label.text = str("Cost: ", economy.getCellCooldownPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
	
	#Set initial labels of purchase panels
	cell_cooldown_label.text = str("Finish resting in [color=#E47DFF]", (player_stats.get_total_wait_time()), "[/color] secs")
	rate_upgrade_label.text = str("Workers collect [color=#E47DFF]", int(player_stats.get_collection_rate()), "[/color] nectar")
	speed_upgrade_label.text = str("They return in [color=#E47DFF]", (player_stats.get_collectible_wait_time()), "[/color] secs")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	nectar_amount_label.text = str("[img]res://assets/img/ui/nectar.png[/img] ", economy.getNectarAmount() )
	bee_amount_label.text = str("[img]res://assets/img/worker/Bee_Head.png[/img] ", economy.getBeeAmount())
	
	updatePricePanel()
	
	
	
func updatePricePanel() -> void:
	var mousePos :Vector2 = get_viewport().get_mouse_position()
	if mousePos:
		price_panel.position = mousePos


func _on_cell_upgrade_button_pressed() -> void:
	if player_stats.get_total_wait_time() >= 0.1:
		var bought = economy.buyCellCooldownUpgrade()
		if bought:
			cell_cooldown_label.text = str("Finish resting in [color=#E47DFF]", player_stats.upgrade_cell_cooldown_rate(), "[/color] secs")
			cell_cost_label.text = str("Cost: ", economy.getCellCooldownPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
			#cell_upgrade_button.text = str("Price: ", economy.getCellCooldownPrice())
		


func _on_rate_upgrade_button_pressed() -> void:
	var bought = economy.buyCollectionUpgrade()
	if bought: 
		if economy.collection_rate_purchases < 3:
			rate_upgrade_label.text = str("Workers collect [color=#E47DFF]", int(player_stats.upgrade_collection_rate(2)), "[/color] nectar")
			rate_cost_label.text = str("Cost: ", economy.getCollectionPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
		else:
			rate_upgrade_label.text = str("Workers collect [color=#E47DFF]", int(player_stats.upgrade_collection_rate()), "[/color] nectar")
			rate_cost_label.text = str("Cost: ", economy.getCollectionPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
		#rate_upgrade_button.text = str("Price: ", economy.getCollectionPrice())


func _on_speed_upgrade_button_pressed() -> void:
	if player_stats.get_collectible_wait_time() >= 0.1:
		var bought = economy.buySpeedUpgrade()
		if bought: 
			speed_upgrade_label.text = str("They return in [color=#E47DFF]", (player_stats.upgrade_collectible_wait_time()), "[/color] secs")
			speed_cost_label.text = str("Cost: ", economy.getCollectiblePrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")


func _on_hive_bridge_pressed() -> void:
	var bought = economy.buyMegaUpgrade()
	if bought: 
		rate_upgrade_label.text = str("Workers collect [color=#E47DFF]", int(player_stats.upgrade_collection_rate(2)), "[/color] nectar")
		rate_cost_label.text = str("Cost: ", economy.getCollectionPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
		var splash_scene = load("res://src/scenes/SplashFade.tscn").instantiate()
		get_parent().add_child(splash_scene)
		hive_button.disabled = true
		hive_button.focus_mode = Control.FOCUS_NONE


func _on_royal_jelly_pressed() -> void:
	var bought = economy.buyMegaUpgrade()
	if bought: 
		rate_upgrade_label.text = str("Workers collect [color=#E47DFF]", int(player_stats.upgrade_collection_rate(2)), "[/color] nectar")
		rate_cost_label.text = str("Cost: ", economy.getCollectionPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
		var splash_scene = load("res://src/scenes/SplashFade.tscn").instantiate()
		get_parent().add_child(splash_scene)
		royal_jelly_button.disabled = true
		royal_jelly_button.focus_mode = Control.FOCUS_NONE


func _on_mega_flora_pressed() -> void:
	var bought = economy.buyMegaUpgrade()
	if bought: 
		rate_upgrade_label.text = str("Workers collect [color=#E47DFF]", int(player_stats.upgrade_collection_rate(2)), "[/color] nectar")
		rate_cost_label.text = str("Cost: ", economy.getCollectionPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
		var splash_scene = load("res://src/scenes/SplashFade.tscn").instantiate()
		get_parent().add_child(splash_scene)
		mega_flora_button.disabled = true
		mega_flora_button.focus_mode = Control.FOCUS_NONE


func _on_triple_cells_pressed() -> void:
	var bought = economy.buyMegaUpgrade()
	if bought: 
		rate_upgrade_label.text = str("Workers collect [color=#E47DFF]", int(player_stats.upgrade_collection_rate(2)), "[/color] nectar")
		rate_cost_label.text = str("Cost: ", economy.getCollectionPrice(), " [img width=10%]res://assets/img/ui/nectar.png[/img]")
		var splash_scene = load("res://src/scenes/SplashFade.tscn").instantiate()
		get_parent().add_child(splash_scene)
		triple_cells_button.disabled = true
		triple_cells_button.focus_mode = Control.FOCUS_NONE


func _on_help_button_pressed() -> void:
	help_menu.visible = true


func _on_rate_upgrade_button_mouse_entered() -> void:
	price_panel.set_price(economy.getCollectionPrice())
	price_panel.visible = true


func _on_rate_upgrade_button_mouse_exited() -> void:
	price_panel.visible = false
	price_panel.upgrades_panel = false


func _on_speed_upgrade_button_mouse_entered() -> void:
	price_panel.set_price(economy.getCollectiblePrice())
	price_panel.visible = true


func _on_speed_upgrade_button_mouse_exited() -> void:
	price_panel.visible = false
	price_panel.upgrades_panel = false


func _on_cell_upgrade_button_mouse_entered() -> void:
	price_panel.set_price(economy.getCellCooldownPrice())
	price_panel.visible = true


func _on_cell_upgrade_button_mouse_exited() -> void:
	price_panel.visible = false
	price_panel.upgrades_panel = false


func _on_hive_bridge_button_mouse_entered() -> void:
	if !hive_button.disabled:
		price_panel.set_price(economy.getMegaUpgradePrice())
		price_panel.visible = true


func _on_hive_bridge_button_mouse_exited() -> void:
	price_panel.visible = false
	price_panel.upgrades_panel = false


func _on_royal_jelly_button_mouse_entered() -> void:
	if !royal_jelly_button.disabled:
		price_panel.set_price(economy.getMegaUpgradePrice())
		price_panel.visible = true


func _on_royal_jelly_button_mouse_exited() -> void:
	price_panel.visible = false
	price_panel.upgrades_panel = false


func _on_mega_flora_button_mouse_entered() -> void:
	if !mega_flora_button.disabled:
		price_panel.set_price(economy.getMegaUpgradePrice())
		price_panel.visible = true


func _on_mega_flora_button_mouse_exited() -> void:
	price_panel.visible = false
	price_panel.upgrades_panel = false


func _on_triple_cells_button_mouse_entered() -> void:
	if !triple_cells_button.disabled:
		price_panel.set_price(economy.getMegaUpgradePrice())
		price_panel.visible = true


func _on_triple_cells_button_mouse_exited() -> void:
	price_panel.visible = false
	price_panel.upgrades_panel = false


func _on_cell_area_mouse_exited() -> void:
	price_panel.upgrades_panel = true


func _on_cell_area_mouse_entered() -> void:
	price_panel.upgrades_panel = false


func _on_upgrade_area_mouse_entered() -> void:
	price_panel.upgrades_panel = true


func _on_upgrade_area_mouse_exited() -> void:
	price_panel.upgrades_panel = false
