extends Control

@onready var economy: Node = $"../../../Systems/Economy"
@onready var rich_text_label: RichTextLabel = $PanelContainer/MarginContainer/RichTextLabel
@onready var panel_container: PanelContainer = $PanelContainer

var price :int = 0
var upgrades_panel :bool = false

func _ready() -> void:
	panel_container.global_position.y -= panel_container.size.y

func _process(_delta: float) -> void:
	if upgrades_panel:
		rich_text_label.text = str("Price: ", price, " [img]res://assets/img/ui/nectar.png[/img]")
	else:
		rich_text_label.text = str("Price: ", economy.getCellPrice(), " [img]res://assets/img/ui/nectar.png[/img]")


func set_price(new_price: int) -> void:
	price = new_price
	upgrades_panel = true
	
