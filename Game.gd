extends Node

@onready var player : Player = get_parent().get_node("World").get_node("Player")
# NPC currently being talked to
var currentNPC : Node
# Inventory slots
var inventoryItems: Array = []
var playerMoney: int = 30
# If the scene has changed before.
# Determines if we want to transfer state from the old scene or not
var sceneChanged = false

class Item:

	var spriteFrameIndex: int
	var name: String
	var id: int
	var tags: Array
	var value: int

	func _init(id, spriteFrameIndex, name, value, tags = []):
		self.spriteFrameIndex = spriteFrameIndex
		self.name = name
		self.id = id
		self.tags = tags
		self.value = value

	static func compareID(itemA, itemB):
		return itemA.id < itemB.id
		
	static func compareValueByID(itemIDA, itemIDB):
		var itemA = Game.getItemByID(itemIDA)
		var itemB = Game.getItemByID(itemIDB)
		return itemA.value < itemB.value

var items = [Item.new(0, 45, "Magic Book", 10), Item.new(1, 272, "Scroll of Flight", 7), Item.new(2, 253, "Horse Head", 33), Item.new(3, 225, "Fossil", 42), Item.new(4, 185, "Strawberry", 2, ["food"])]

func getItemByID(id):
	return items[id]

func sellItemToPlayer(itemID, price):
	assert(player.inv.freeSpaces() > 0)
	assert(playerMoney >= price)
	player.inv.addItem(itemID)
	setMoney(playerMoney - price)

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

func setScene(scene_path : String):
	call_deferred("_deferred_setScene", scene_path)

func _deferred_setScene(scene_path: String):
	sceneChanged = true
	get_tree().change_scene_to_file(scene_path)

func onSceneReady():
	if not sceneChanged:
		return
	player = get_parent().get_node("World").get_node("Player")
	for itemID in inventoryItems:
		player.inv.addItem(itemID)
	
func setInventoryItem(slot: int, itemID: int):
	inventoryItems.resize(slot + 1)
	inventoryItems[slot] = itemID

func setMoney(amount):
	assert(amount >= 0)
	playerMoney = amount
