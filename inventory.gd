extends Panel

@onready var slots = get_tree().get_nodes_in_group("InventorySlot")
@onready var moneyLabel = get_node("Money")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.visible:
		moneyLabel.text = "Money: " + str(Game.playerMoney) + " / " + str(Game.quota)

func on_input(event, slot):
	pass

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo() and event.keycode == KEY_I:
		self.visible = !self.visible

func isOpen():
	return self.visible

func freeSpaces():
	var spaces = 0
	for slot in slots:
		if slot.isEmpty():
			spaces += 1
	return spaces

func isEmpty():
	for slot in slots:
		if not slot.isEmpty():
			return false
	return true

func addItem(itemID, tooltip: String = ""):
	for slot in slots:
		if slot.isEmpty():
			slot.setItem(itemID, tooltip)
			return
	assert(false)

func setItem(slot: int, itemID: int, tooltip: String = ""):
	slots[slot].setItem(itemID, tooltip)

func setEmpty(slot: int):
	slots[slot].setEmpty()
	
func hasItemWithTag(tag):
	for slot in slots:
		if not slot.isEmpty() and tag in Game.getItemByID(slot.itemID).tags:
			return true
	return false

func removeFirstItemWithTag(tag):
	for slot in slots:
		if not slot.isEmpty() and tag in Game.getItemByID(slot.itemID).tags:
			slot.setEmpty()
			return true
	return false

func items(sortFn = null):
	var items = []
	for slot in slots:
		if not slot.isEmpty():
			items.append(slot.itemID)
	if sortFn:
		items.sort_custom(sortFn)
	print(items)
	return items

func removeItem(itemID):
	print("removing " + str(itemID))
	for slot in slots:
		print("slot has " + str(slot.itemID))
		if slot.itemID == itemID:
			slot.setEmpty()
			return
