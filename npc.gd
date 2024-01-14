extends StaticBody2D

@export var dialogue: DialogueResource = null
@onready var anim = get_node("AnimatedSprite2D")
@export var itemsInStock : int = 0
@export var forcedInteraction : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func onPlayerDetected(player):
	if forcedInteraction and dialogue:
		startDialogue(player)

func onInteractedWithByPlayer(player):
	startDialogue(player)

func startDialogue(player):
	Game.currentNPC = self
	player.startDialogue(dialogue)
