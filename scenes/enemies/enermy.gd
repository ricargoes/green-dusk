class_name Enemy extends CharacterBody2D

@export
var resource_type = PoolManager.PoolResource.BASIC_ENEMY
@export
var xp_value: int = 200
@export
var max_life_points: float = 20.0
@export
var contact_dps: float = 5.0

var dead: bool = true

var life_points = 1

signal defeated(who)

func _ready() -> void:
	var hero = get_tree().get_first_node_in_group("hero")
	defeated.connect(hero.on_enermy_defeated)

func _enter_tree():
	life_points = max_life_points
	dead = false
	_custom_entry_behaviour()

func _custom_entry_behaviour():
	pass

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += delta*GameConstants.GRAVITY
	move_and_slide()
	
	fall_check()
	contact_attack(delta)

func fall_check():
	if global_position.y > GameConstants.DEATH_GLOBAL_Y_POSITION:
		shelf()

func contact_attack(delta: float):
	for body in $ContactDamageArea.get_overlapping_bodies():
		if body.has_method("hurt"):
			body.hurt(contact_dps*delta)

func hurt(damage: float):
	var hero = get_tree().get_first_node_in_group("hero")
	hero.steal_life(damage)
	life_points -= damage
	if life_points <= 0:
		die()

func die():
	defeated.emit(self)
	shelf()

func shelf():
	dead = true
	PoolManager.shelf_instance(self)
