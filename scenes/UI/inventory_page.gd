extends CanvasLayer

@onready var item_lb: RichTextLabel = $Control/PanelContainer/TabContainer/Items/PanelContainer/VBoxContainer/itemLB
@onready var type_lb: RichTextLabel = $Control/PanelContainer/TabContainer/Items/PanelContainer/VBoxContainer/typeLB
@onready var amount_lb: RichTextLabel = $Control/PanelContainer/TabContainer/Items/PanelContainer/VBoxContainer/amountLB
@onready var rarity_lb: RichTextLabel = $Control/PanelContainer/TabContainer/Items/PanelContainer/VBoxContainer/rarityLB




@onready var item_scene:PackedScene = preload("res://scenes/UI/item_for_grid.tscn")
var item_data
var instantiated_item
var rarity


func inventory_menu():
	print("hello")
	get_tree().paused = true
	get_child(0).process_mode = Node.PROCESS_MODE_INHERIT
	populate_grid()
	show()

func _ready() -> void:


	item_lb.bbcode_enabled = true
	type_lb.bbcode_enabled = true
	amount_lb.bbcode_enabled = true
	rarity_lb.bbcode_enabled = true
	item_lb.bbcode_text = "press to view info"
	

func populate_grid():
	for child in $Control/PanelContainer/TabContainer/Items/MarginContainer/GridContainer.get_children():
		child.queue_free()
	for item in Inventory.items:
		item_data = load("res://resources/items/%s.tres"% item) as ItemInfo

		instantiated_item = item_scene.instantiate()
		instantiated_item.populate(item_data)
		$Control/PanelContainer/TabContainer/Items/MarginContainer/GridContainer.add_child(instantiated_item)
	for clickable_icon in get_tree().get_nodes_in_group("clickable_icons"):
		clickable_icon.connect("item_input", change_description)
		
func change_description(data):
	rarity = data.get_rarity()
	item_lb.bbcode_text = "Item: %s" % [data.name]
	type_lb.bbcode_text = "type: %s" % [str(data.get_type())]
	rarity_lb.bbcode_text = "rarity: [color=%s]%s[/color]" % [rarity[0],rarity[1]]
	amount_lb.bbcode_text = "amount: %s" % [str(Inventory.items[data.name])]


func _on_texture_button_pressed() -> void:
	hide()
	get_child(0).process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
