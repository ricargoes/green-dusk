extends Node2D

const PISTOL_RANGE = 1000

@export
var shooting_cooldown: float = 0.3
@export
var arm_rotation_speed: float = PI

var target: Enemy = null

func _ready() -> void:
	$ShootingCooldown.wait_time = shooting_cooldown

func _process(delta: float) -> void:
	if target == null or target.dead or target.global_position.distance_to(target.global_position) > PISTOL_RANGE:
		select_target()
	
	var target_orientation = global_position.angle_to_point(target.global_position) if target != null else 0.0
	rotation = rotate_toward(rotation, target_orientation, arm_rotation_speed*delta)


func shoot():
	var orientation = rotation
	var game = get_tree().current_scene
	game.spawn_bullet(global_position + Vector2.from_angle(orientation)*120, orientation, true)

func set_level(level: int):
	match level:
		1:
			shooting_cooldown = 0.3
			arm_rotation_speed = PI

func cooldown_boost(boost: float):
	$ShootingCooldown.wait_time = shooting_cooldown/boost
	OnScreenTerminal.log($ShootingCooldown.wait_time)

func select_target():
	target = null
	var hero: Node2D = get_tree().get_first_node_in_group("hero")
	var enemies: Array = hero.get_enemies_on_sight()
	target = null if enemies.is_empty() else enemies[randi() % enemies.size()]
