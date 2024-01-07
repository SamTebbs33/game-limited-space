extends Panel

var isOpen = true;

@onready var slots = get_tree().get_nodes_in_group("InventorySlot")

# Called when the node enters the scene tree for the first time.
func _ready():
	isOpen = self.visible
	# Fill the inventory with random items
	var rng = RandomNumberGenerator.new()
	for slot in slots:
		if rng.randi_range(0, 1) == 1:
			slot.setItem(rng.randi_range(0, Game.items.size() - 1))
		else:
			slot.setEmpty()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_input(event, slot):
	pass

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo() and event.keycode == KEY_E:
		isOpen = !isOpen
		self.visible = isOpen
