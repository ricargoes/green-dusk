extends Area2D


@export
var pos_left := Vector2(-800, 0)
@export
var pos_right := Vector2(800, 0)
@export
var dps: float = 30.0
@export
var speed: float = 900

var speed_boost: float = 1.0

var target: Vector2 = pos_right

func _process(delta: float) -> void:
	var path_to_target: Vector2 = (target - position)
	position += speed*speed_boost*path_to_target.normalized()*delta
	if path_to_target.length() < 50:
		target = pos_left if target == pos_right else pos_right
	
	for enemy: Enemy in get_overlapping_bodies():
		enemy.hurt(dps*delta)

func cooldown_boost(boost: float):
	speed_boost = boost

func set_level(level: int):
	match level:
		1:
			pos_left = Vector2(-400, 0)
			pos_right = Vector2(400, 0)
			dps = 30.0
			speed = 600
		2:
			pos_left = Vector2(-600, 0)
			pos_right = Vector2(600, 0)
			dps = 30.0
			speed = 900
			scale = Vector2(1.5, 1.5)
		3:
			pos_left = Vector2(-800, 0)
			pos_right = Vector2(800, 0)
			dps = 30.0
			speed = 900
			scale = Vector2(2.0, 2.0)
		4:
			pos_left = Vector2(-800, 0)
			pos_right = Vector2(800, 0)
			dps = 40.0
			speed = 900
			scale = Vector2(2.0, 2.0)
		5:
			pos_left = Vector2(-800, 0)
			pos_right = Vector2(800, 0)
			dps = 50.0
			speed = 1200
			scale = Vector2(4.0, 4.0)
