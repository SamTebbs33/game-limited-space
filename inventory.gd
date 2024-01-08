extends Panel

@onready var slots = get_tree().get_nodes_in_group("InventorySlot")
@onready var moneyLabel = get_node("Money")
var money = 30

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.visible:
		moneyLabel.text = "Money: " + str(money)

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
	
func addItem(itemID):
	for slot in slots:
		if slot.isEmpty():
			slot.setItem(itemID)
			return
	assert(false)

func setMoney(amount):
	assert(amount >= 0)
	self.money = amount
	
func hasItemWithTag(tag):
	for slot in slots:
		if not slot.isEmpty() and tag in Game.getItemByID(slot.itemID).tags:
			return true
	return false
