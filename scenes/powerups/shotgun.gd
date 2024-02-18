extends Sprite2D

@export
var rotation_speed = PI
@export
var cooldown_time: float = 0.5

var level = 1

func _ready() -> void:
	$Cooldown.wait_time = cooldown_time

func shoot():
	var game = get_tree().current_scene
	game.spawn_bullet(global_position + Vector2.from_angle(rotation)*120, rotation-PI/12, true, 0.5)
	game.spawn_bullet(global_position + Vector2.from_angle(rotation)*120, rotation, true, 0.5)
	game.spawn_bullet(global_position + Vector2.from_angle(rotation)*120, rotation+PI/12, true, 0.5)

func _process(delta: float) -> void:
	var target = select_target()
	if target == null:
		rotation = 0
	else:
		rotation = rotate_toward(rotation, global_position.angle_to_point(target.global_position), rotation_speed*delta)

func select_target() -> Node2D:
	var target = null
	var min_distance = null
	var hero: Node2D = get_tree().get_first_node_in_group("hero")
	for enemy: Enemy in hero.get_enemies_on_sight():
		var distances_square_to_enemy = global_position.distance_squared_to(enemy.global_position)
		if min_distance == null or distances_square_to_enemy < min_distance:
			min_distance = distances_square_to_enemy
			target = enemy
	return target


func cooldown_boost(boost: float):
	$Cooldown.wait_time = cooldown_time/boost

func set_level(new_level: int):
	level = new_level
	match level:
		1:
			rotation_speed = PI
			cooldown_time = 0.5
		
