extends CanvasLayer


@onready var money:Label  = $Control/Consumables/MarginContainer/HBoxContainer/money
@onready var tuna:Label  = $Control/Consumables/MarginContainer/HBoxContainer/tuna
@onready var wildcard:TextureRect = $Control/Wildcard/MarginContainer/HBoxContainer/TextureRect
@onready var wildcard_text:RichTextLabel = $Control/Wildcard/MarginContainer/HBoxContainer/Label
@onready var wild_panel:PanelContainer = $Control/Wildcard
@onready var health_bar:TextureProgressBar =  $Control/TextureProgressBar
var item_data:ItemInfo

var consumables: Array = ["money", "tuna", "health"]
var tween

func _ready() -> void:
	tween = create_tween()
	tween.tween_property(health_bar, "value", float(Inventory.consumables["health"]), 3)
	wild_panel.modulate.a = 0.0

	Inventory.connect("update_consumables_ui", update_consumables)
	Inventory.connect("update_wildcard_ui", update_wildcard)



func update_consumables(item:String, item_amount:int):
	match item:
		"money":
			money.text = str(item_amount)
		"tuna":
			tuna.text = str(item_amount)
		"health":
			print("health changed")
			health_bar.value = item_amount

func update_wildcard(item:ItemInfo, item_amount):
	item_data = item
	wildcard.texture = item_data.icon
	wildcard_text.bbcode_text = "[wave amp=12.0 freq=5.0 connected=1]+ %s[/wave]" % [str(item_amount)]
	tween = create_tween()
	tween.tween_property(wild_panel, "modulate:a", 1.0, 1)
	tween.tween_interval(1.0)
	tween.tween_property(wild_panel, "modulate:a", 0, 1)



		
		
	
