extends Node2D

@export
var shooting_cooldown: float = 0.3
@export
var arm_rotation_speed: float = 4*PI

var target: Enemy = null

func _ready() -> void:
	$ShootingCooldown.wait_time = shooting_cooldown

func _process(delta: float) -> void:
	if target == null or target.dead:
		select_target()
	
	var target_orientation = global_position.angle_to_point(target.global_position) if target != null else 0.0
	aim_to(target_orientation, delta)


func shoot():
	var orientation = rotation
	var game = get_tree().current_scene
	game.spawn_bullet(global_position + Vector2.from_angle(orientation)*120, orientation, true)

func set_level(level: int):
	match level:
		1:
			shooting_cooldown = 0.3
			arm_rotation_speed = 4*PI

func cooldown_boost(boost: float):
	$ShootingCooldown.wait_time = shooting_cooldown/boost

func select_target():
	target = null
	var pistol_range = 1000
	for enemy: Node2D in get_tree().get_nodes_in_group("enemies"):
		if (enemy.global_position - global_position).length() < pistol_range:
			target = enemy

func aim_to(target_orientation: float, delta: float):
	var rotation_strength = fmod(target_orientation-rotation, PI)/PI
	rotation += rotation_strength*arm_rotation_speed*delta
