extends Control


@onready var player_stats: Node = %PlayerStats
@onready var economy: Node = %Economy
@onready var nectar_amount_label: RichTextLabel = %NectarAmountLabel
@onready var bee_amount_label: RichTextLabel = %BeeAmountLabel
@onready var price_panel: Control = $PricePanel
@onready var cell_cooldown_label: Label = $Panel/VBoxContainer/CellCooldownUpgradePanel2/Panel/VBoxContainer/Label
@onready var rate_upgrade_label: RichTextLabel = $"Panel/VBoxContainer/RateUpgradePanel/Panel/MarginContainer/HBox/VBoxContainer/Label2"
@onready var rate_upgrade_button: Button = $Panel/VBoxContainer/RateUpgradePanel/Panel/VBoxContainer/RateUpgradeButton
@onready var cell_upgrade_button: Button = $Panel/VBoxContainer/CellCooldownUpgradePanel2/Panel/VBoxContainer/CellUpgradeButton

@onready var rate_panel: Panel = $Panel/VBoxContainer/RateUpgradePanel/Panel

func _ready() -> void:
	nectar_amount_label.text = str("[img]res://assets/img/ui/nectar.png[/img] 0")
	bee_amount_label.text = str("[img]res://src/scenes/worker_bee.tscn::AtlasTexture_xt75n[/img] 0")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	nectar_amount_label.text = str("[img]res://assets/img/ui/nectar.png[/img] ", economy.getNectarAmount() )
	bee_amount_label.text = str("[img]res://src/scenes/worker_bee.tscn::AtlasTexture_xt75n[/img] ", economy.getBeeAmount())
	
	updatePricePanel()
	
	
	
func updatePricePanel() -> void:
	var mousePos :Vector2 = get_viewport().get_mouse_position()
	if mousePos:
		price_panel.position = mousePos


func _on_cell_upgrade_button_pressed() -> void:
	var bought = economy.buyCellCooldownUpgrade()
	if bought:
		cell_cooldown_label.text = str("Bee Cooldown Speed: ", player_stats.upgrade_cell_cooldown_rate(), "x")
		#cell_upgrade_button.text = str("Price: ", economy.getCellCooldownPrice())
		


func _on_rate_upgrade_button_pressed() -> void:
	var bought = economy.buyCollectionUpgrade()
	if bought: 
		rate_upgrade_label.text = str("Workers collect [color=#E47DFF]", int(player_stats.upgrade_collection_rate()), "[/color] nectar")
		#rate_upgrade_button.text = str("Price: ", economy.getCollectionPrice())


func _on_panel_mouse_entered() -> void:
	price_panel.visible = true


func _on_panel_mouse_exited() -> void:
	price_panel.visible = false
