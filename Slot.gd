extends Panel

@export var slotIndex = 0

@onready var sprite = get_node("AnimatedSprite2D")
@onready var inv = get_parent()

const EMPTY_FRAME_INDEX = 284

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setItem(itemID):
	var item = Game.getItemByID(itemID)
	sprite.frame = item.spriteFrameIndex
	self.set_tooltip_text(item.name)
	
func setEmpty():
	sprite.frame = EMPTY_FRAME_INDEX


func _on_gui_input(event):
	if event is InputEventMouseButton:
		inv.on_input(event, slotIndex)
