extends CharacterBody2D

const JUMP_FORCE = 3000
const MAX_JUMP_IMPULSE_TIME: float = 0.3

@export
var player_speed: int = 200
@export
var life_points: float = 100

var jump_impulse_time: float = 0.0

func _ready() -> void:
	velocity.x = player_speed
	$UI.sync_life(life_points)

func _process(delta: float) -> void:
	
	if is_on_floor():
		jump_impulse_time = MAX_JUMP_IMPULSE_TIME
	else:
		jump_impulse_time -= delta
		velocity.y += delta*GameConstants.GRAVITY
	
	if Input.is_action_pressed("jump") and jump_impulse_time > 0:
		velocity.y -= delta*JUMP_FORCE
	
	move_and_slide()
	
	if global_position.y > GameConstants.DEATH_GLOBAL_Y_POSITION:
		hurt(1000)

func hurt(damage: float):
	life_points -= damage
	$UI.sync_life(life_points)
	if life_points <= 0:
		die()

func die():
	get_tree().quit()
