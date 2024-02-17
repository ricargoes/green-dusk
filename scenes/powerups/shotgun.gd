extends Sprite2D

@export
var rotation_speed = 2*PI
@export
var cooldown_time: float = 0.5

var level = 1

func _ready() -> void:
	$Cooldown.wait_time = cooldown_time

func shoot():
	var game = get_tree().current_scene
	game.spawn_bullet(global_position + Vector2.from_angle(rotation)*120, rotation-PI/12, true)
	game.spawn_bullet(global_position + Vector2.from_angle(rotation)*120, rotation, true)
	game.spawn_bullet(global_position + Vector2.from_angle(rotation)*120, rotation+PI/12, true)

func _process(delta: float) -> void:
	var target = select_target()
	if target == null:
		rotation = 0
	else:
		aim_to(target.global_position, delta)

func select_target() -> Node2D:
	var target = null
	var current_min_distance = 10000
	for enemy: Node2D in get_tree().get_nodes_in_group("enemies"):
		if (enemy.global_position - global_position).length() < current_min_distance:
			target = enemy
	return target

func aim_to(location: Vector2, delta: float):
	var target_orientation = global_position.angle_to_point(location)
	var rotation_strength = fmod(target_orientation-rotation, PI)/PI
	rotation += rotation_strength*rotation_speed*delta

func cooldown_boost(boost: float):
	$Cooldown.wait_time = cooldown_time/boost

func set_level(new_level: int):
	level = new_level
	match level:
		1:
			rotation_speed = 2*PI
			cooldown_time = 0.5
		
