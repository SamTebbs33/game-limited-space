extends Panel

@onready var slots = get_tree().get_nodes_in_group("InventorySlot")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_input(event, slot):
	pass

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo() and event.keycode == KEY_E:
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
