extends Area2D
class_name PlayerDetection

@onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func onInteractedWithByPlayer(player):
	parent.onInteractedWithByPlayer(player)

func _on_body_entered(body):
	if body.name == "Player" and not body.isBusy():
		parent.onPlayerDetected(body);
