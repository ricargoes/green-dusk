extends CharacterBody2D

const BULLET_LIFETIME: float = 1

var resource_type = PoolManager.PoolResource.BULLET
@export
var is_player: bool = false
@export
var orientation: float = 0.0
@export
var bullet_speed: float = 1000
@export
var damage: float = 10.0

var time_left: float = 1

func _enter_tree():
	collision_mask = 4
	if is_player:
		collision_mask += 2
	else:
		collision_mask += 1
	
	velocity = Vector2.from_angle(orientation)*bullet_speed
	rotation = orientation
	time_left = BULLET_LIFETIME

func _process(delta: float) -> void:
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.get_collider().has_method("hurt"):
			collision.get_collider().hurt(damage)
		
		PoolManager.shelf_instance(self)
	
	time_left -= delta
	if time_left < 0:
		PoolManager.shelf_instance(self)
