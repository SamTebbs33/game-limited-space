extends Node2D

@onready var anim : AnimatedSprite2D = get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func onPlayerDetected(player):
	pass

func onInteractedWithByPlayer(player):
	print("shop interacted with")
