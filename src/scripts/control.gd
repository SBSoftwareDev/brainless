extends Control

@onready var economy: Node = %Economy
@onready var nectar_amount_label: RichTextLabel = %NectarAmountLabel
@onready var bee_amount_label: RichTextLabel = %BeeAmountLabel
@onready var price_panel: Control = $PricePanel

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
