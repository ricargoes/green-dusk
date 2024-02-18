extends Node2D

@export
var hit_damage: int = 12
@export
var swing_speed: float = PI

var swing_speed_boost: float = 1

func _process(delta: float) -> void:
	rotate(swing_speed*swing_speed_boost*delta)

func cooldown_boost(boost: float):
	swing_speed_boost = boost

func _on_sword_edge_body_entered(enemy: Enemy) -> void:
	enemy.hurt(hit_damage)

func set_level(new_level: int):
	match new_level:
		1:
			swing_speed = PI
			hit_damage = 4
		2:
			swing_speed = 1.2*PI
			hit_damage = 6
		3:
			swing_speed = 1.6*PI
			hit_damage = 6
			scale = Vector2(1.3, 1.3)
		4:
			swing_speed = 2*PI
			hit_damage = 6
			scale = Vector2(1.3, 1.3)
		5:
			swing_speed = 4*PI
			hit_damage = 6
			scale = Vector2(1.3, 1.3)
