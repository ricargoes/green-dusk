extends CharacterBody2D

const JUMP_FORCE = 3000
const GRAVITY: float = 980.0
const MAX_JUMP_ENERGY: float = 0.3

var jump_energy: float = 0.0

func _process(delta: float) -> void:
	
	if is_on_floor():
		jump_energy = MAX_JUMP_ENERGY
	else:
		jump_energy -= delta
		velocity.y += delta*GRAVITY
	
	if Input.is_action_pressed("jump") and jump_energy > 0:
		velocity.y -= delta*JUMP_FORCE
	
	move_and_slide()
