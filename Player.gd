extends Area2D

signal hit

export var speed = 400	# in pixels/sec
var bounds


## CALLBACKS ##

func _ready():
	bounds = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if velocity.length() > 0:
		if velocity.length() > 1:
			velocity = velocity.normalized()
		velocity *= speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, bounds.x)
	position.y = clamp(position.y, 0, bounds.y)

	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
