extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -175.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var currentDialogueBalloon: CanvasLayer

@onready var anim = get_node("AnimatedSprite2D")
@onready var inv = get_node("Inventory")

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not isBusy():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right") if not isBusy() else 0
	if direction:
		if velocity.y == 0:
			anim.play("Walk")
		velocity.x = direction * SPEED
	else:
		anim.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction < 0:
		anim.flip_h = true;
	elif direction > 0:
		anim.flip_h = false;

	move_and_slide()

func startDialogue(dialogue):
	assert(not isBusy())
	currentDialogueBalloon = DialogueManager.show_example_dialogue_balloon(dialogue, "start")

func isBusy():
	# The player characteris busy if they're talking to an NPC or if they have the inventory open
	return inv.isOpen() or is_instance_valid(currentDialogueBalloon)
