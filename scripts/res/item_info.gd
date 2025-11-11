extends Resource

class_name ItemInfo
@export var icon:Texture2D
@export var name:String

@export var type: types
@export var rarity:xp_values
@export var amount:int = 1

var lucky_num:int


enum xp_values{
	COMMON = 10,
	UNCOMMON = 20,
	RARE = 50,
	VERY_RARE = 100
}


enum types{
	CONSUMABLE,
	MATERIAL,
	TOOL,
	WEAPON,
	COSMETIC
} 

func get_rarity():
	print(rarity)
	match rarity:
		xp_values.COMMON:
			return ["white","common"]
		xp_values.UNCOMMON:
			return ["orange", "uncommon"]
		xp_values.RARE:
			return ["yellow", "rare"]
		xp_values.VERY_RARE:
			return ["purple", "very rare"]
			
func get_type():

	match type:
		types.CONSUMABLE:
			return "consumable"
		types.MATERIAL:
			return "material"
		types.TOOL:
			return "tool"
		types.WEAPON:
			return "weapon"
		types.COSMETIC:
			return "cosmetic"

func bonus():
	lucky_num = randi_range(0,10)
	if lucky_num == 10:
		print("recieve bonus reward!")
