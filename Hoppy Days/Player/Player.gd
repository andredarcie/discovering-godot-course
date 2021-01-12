extends KinematicBody2D

var motion = Vector2(0, 0)

const SPEED = 1500
const GRAVITY = 300
const UP = Vector2(0, -1)
const JUMP_SPEED = 3000

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)
	
	
func apply_gravity():
	if not is_on_floor():
		motion.y += GRAVITY
	else:
		motion.y = 0
		
		
func jump():
	if is_on_floor() and Input.is_action_pressed("Jump"):
		motion.y -= JUMP_SPEED
		
		
func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0
		
		
func animate():
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	elif motion.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif motion.x < 0: 
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
	
