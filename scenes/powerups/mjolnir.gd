extends Node2D

@export
var pos_x_left := -900
@export
var pos_x_right := 900
@export
var hit_damage: float = 20.0
@export
var lightning_cooldown: float = 1.0
@export
var speed: float = 900

var lighning_cooldown: float = 1.0

var target_x: float = pos_x_right
var cooldown_booster: float = 1.0

func _ready() -> void:
	$Cooldown.wait_time = lightning_cooldown

func _process(delta: float) -> void:
	global_position.y = 20
	var distance_to_target: float = (target_x - position.x)
	position.x += sign(distance_to_target)*speed*delta
	if abs(distance_to_target) < 100:
		OnScreenTerminal.log(target_x)
		target_x = pos_x_left if target_x == pos_x_right else pos_x_right
	
func lightning() -> void:
	var lighning_distance = $Probe.get_collision_point().y - global_position.y if $Probe.is_colliding() else 2500

	$Lightning.scale.y = lighning_distance/908
	$Lightning.show()
	$LightningFlash.start()
	for enemy: Enemy in $Lightning.get_overlapping_bodies():
		enemy.hurt(hit_damage)

func cooldown_boost(boost: float):
	cooldown_booster = boost
	$Cooldown.wait_time = lightning_cooldown/boost

func set_level(level: int):
	match level:
		1:
			hit_damage = 20.0
			lightning_cooldown = 0.75
		2:
			hit_damage = 20.0
			lightning_cooldown = 0.5
		3:
			hit_damage = 40.0
			lightning_cooldown = 0.5
		4:
			hit_damage = 40.0
			lightning_cooldown = 0.4
		5:
			hit_damage = 50.0
			lightning_cooldown = 0.25
	$Cooldown.wait_time = lightning_cooldown/cooldown_booster


func _on_lightning_flash_timeout() -> void:
	$Lightning.hide()
