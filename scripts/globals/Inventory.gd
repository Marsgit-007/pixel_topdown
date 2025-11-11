extends Node

var items:Dictionary = {}
var consumables:Dictionary = {"health":100, "money":0, "tuna":0}
var player_pos:Vector2
signal update_consumables_ui
signal update_wildcard_ui

func update_items(item, amount):
	if item is ItemInfo:
		match item.name:
			"money", "tuna":
					consumables[item.name] += amount
					update_consumables_ui.emit(item.name, consumables[item.name])
			"health":
					consumables[item.name] += amount
					if consumables[item.name] > 100:
						consumables[item.name] = 100
					update_consumables_ui.emit(item.name, consumables[item.name])
			_:
				if items.has(item.name):
					items[item.name] += amount
				else:
					items[item.name] = amount
				update_wildcard_ui.emit(item,amount)
				if items[item.name] <= 0:
					items.erase(item.name)
				print(items)
	else:
		consumables["health"] -= amount
		if consumables["health"] < 0 :
			consumables["health"] = 0
			TransitionLayer.change_scene("res://scenes/levels/death.tscn")
		update_consumables_ui.emit("health", consumables["health"])
