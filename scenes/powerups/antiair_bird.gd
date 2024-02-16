extends Area2D

@export
var speed: float = 900
@export
var damage: float = 24.0
@export
var cooldown_time: float = 0.5

var target: Enemy = null

func _ready() -> void:
	$Cooldown.wait_time = cooldown_time

func _process(delta: float) -> void:
	if target == null or target.dead:
		var min_distance = 1200
		var hero: Node2D = get_tree().get_first_node_in_group("hero")
		for enemy: Enemy in get_tree().get_nodes_in_group("airborne"):
			var distance_to_hero = (enemy.global_position - hero.global_position).length()
			if distance_to_hero < min_distance:
				min_distance = distance_to_hero
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

func _on_attack_move_animation_finished(anim_name: StringName) -> void:
	for enemy: Enemy in get_overlapping_bodies():
		enemy.hurt(damage)
