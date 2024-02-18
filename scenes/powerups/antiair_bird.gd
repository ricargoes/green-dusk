extends Area2D

@export
var speed: float = 900
@export
var damage: float = 24.0
@export
var cooldown_time: float = 1.5

var target: Enemy = null

func _ready() -> void:
	$Cooldown.wait_time = cooldown_time - 0.5

func _process(delta: float) -> void:
	if not is_inside_tree():
		return
	if target == null or target.dead:
		var min_distance = null
		var hero: Node2D = get_tree().get_first_node_in_group("hero")
		for enemy: Enemy in hero.get_enemies_on_sight():
			if not enemy.is_in_group("airborne"):
				continue
			var distance_squared_to_hero = hero.global_position.distance_squared_to(enemy.global_position)
			if min_distance == null or distance_squared_to_hero < min_distance:
				min_distance = distance_squared_to_hero
				target = enemy
		if target != null and not target.dead:
			$Cooldown.start()
	
	if target == null or target.dead:
		$Cooldown.stop()
	else:
		var velocity = (target.global_position - global_position).normalized()*speed
		global_position += velocity*delta

func attack():
	$AttackMove.play("attack")

func _on_attack_move_animation_finished(_anim_name: StringName) -> void:
	for enemy: Enemy in get_overlapping_bodies():
		enemy.hurt(damage)

func cooldown_boost(boost: float):
	$Cooldown.wait_time = cooldown_time/boost

func set_level(level: int):
	match level:
		1:
			speed = 900
			damage = 24.0
			cooldown_time = 1.5
		2:
			speed = 1500
			damage = 24.0
			cooldown_time = 1.0
		3:
			speed = 1500
			damage = 30.0
			cooldown_time = 1.0
			scale = Vector2(1.5, 1.5)
		4:
			speed = 1500
			damage = 30.0
			cooldown_time = 0.8
			scale = Vector2(2, 2)
		5:
			speed = 1500
			damage = 30.0
			cooldown_time = 0.6
			scale = Vector2(2.5, 2.5)
