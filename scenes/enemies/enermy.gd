extends CharacterBody2D

@export
var resource_type = PoolManager.PoolResource.BASIC_ENEMY
@export
var xp_value: int = 200
@export
var max_life_points: float = 20.0
@export
var contact_dps: float = 50.0

var life_points = 1

signal defeated(who)

func _enter_tree():
	life_points = max_life_points

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += delta*GameConstants.GRAVITY
		
	move_and_slide()
	
	if global_position.y > GameConstants.DEATH_GLOBAL_Y_POSITION:
		die()
	
	for body in $ContactDamageArea.get_overlapping_bodies():
		if body.has_method("hurt"):
			body.hurt(contact_dps*delta)

func hurt(damage: float):
	life_points -= damage
	if life_points <= 0:
		die()

func die():
	defeated.emit(self)
	PoolManager.shelf_instance(self)
