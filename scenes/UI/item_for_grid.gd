extends TextureButton

signal item_input
var item_descrption_data

func populate(data:ItemInfo):
	texture_normal = data.icon
	texture_pressed = ImageTexture.new()
	$Label.text = str(Inventory.items[data.name])
	item_descrption_data = data
	





func _on_pressed() -> void:
	item_input.emit(item_descrption_data)
