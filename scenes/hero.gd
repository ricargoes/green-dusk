extends CharacterBody2D

const JUMP_FORCE = 3000
const MAX_JUMP_IMPULSE_TIME: float = 0.3

@export
var player_speed: int = 200
@export
var life_points: float = 100
@export
var arm_rotation_speed: float = 2*PI

var jump_impulse_time: float = 0.0

signal shot(spawn_position: Vector2, orientation: float)

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
	
	var lock_on_target = select_target()
	aim_to(lock_on_target.global_position, delta)
	
	if Input.is_action_just_pressed("ui_accept"): # To be removed
		shoot()

func hurt(damage: float):
	life_points -= damage
	$UI.sync_life(life_points)
	if life_points <= 0:
		die()

func die():
	get_tree().quit()

func shoot():
	var orientation = $ShoulderPivot.rotation
	shot.emit($ShoulderPivot.global_position + Vector2.from_angle(orientation)*120, orientation)

func select_target() -> Node2D:
	var target = self
	var current_min_distance = 10000
	for enemy: Node2D in get_tree().get_nodes_in_group("enemies"):
		if (enemy.global_position - global_position).length() < current_min_distance:
			target = enemy
	return target

func aim_to(location: Vector2, delta: float):
	var target_orientation = $ShoulderPivot.global_position.angle_to_point(location)
	var rotation_strength = fposmod(target_orientation-$ShoulderPivot.rotation, 2*PI)/PI - 1
	$ShoulderPivot.rotation -= rotation_strength*arm_rotation_speed*delta
	
