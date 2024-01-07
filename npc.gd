extends StaticBody2D

@export var dialogue: DialogueResource
@onready var anim = get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		if not body.isBusy():
			body.startDialogue(dialogue)
