extends Node

class Item:

	var spriteFrameIndex: int
	var name: String
	var id: int

	func _init(id, spriteFrameIndex, name):
		self.spriteFrameIndex = spriteFrameIndex
		self.name = name
		self.id = id
		
	static func compareID(itemA, itemB):
		return itemA.id < itemB.id

var items = [Item.new(0, 45, "Magic Book"), Item.new(1, 272, "Scroll of Flight"), Item.new(2, 253, "Horse Head"), Item.new(3, 225, "Fossil")]

func getItemByID(id):
	return items[id]

func _ready():
	# Make sure no items share an ID
	items.sort_custom(Item.compareID)
	for i in range(1, items.size()):
		assert(items[i].id != items[i - 1].id)

func listProps(class_instance):
	for method in class_instance.get_method_list():
		print(method.name + "()")
	
	for prop in class_instance.get_property_list():
		if prop.type == 3:
			print(prop.name)
