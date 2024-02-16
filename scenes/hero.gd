extends CharacterBody2D

const JUMP_FORCE = 3000
const MAX_JUMP_IMPULSE_TIME: float = 0.3

@export
var player_speed: int = 200
@export
var shooting_cooldown: float = 0.3
@export
var arm_rotation_speed: float = 2*PI

@export
var max_life_points: int = 50
@export
var evasion: int = 0
@export
var attack_frecuency_boost: float = 1.0
@export
var life_steal: float = 0.0

var life_points: float = 50.0
var level: int = 0
var xp: int = 0
var xp_threshold: int = 100
var powerups = { "Pistol": 1 }

var jump_impulse_time: float = 0.0

var pistol_target: Enemy = null

signal died

func _ready() -> void:
	$ShootingCooldown.wait_time = shooting_cooldown
	life_points = max_life_points/2.0
	velocity.x = player_speed
	$UI.sync_life(life_points, max_life_points)
	level_up()

func _process(delta: float) -> void:
	if is_on_floor():
		$Body.animation = "run"
		$Legs.animation = "run"
		$JumpingShape.disabled = true
		$RunningShape.disabled = false
		jump_impulse_time = MAX_JUMP_IMPULSE_TIME
	else:
		$Body.animation = "jump"
		$Legs.animation = "jump"
		$JumpingShape.disabled = false
		$RunningShape.disabled = true
		jump_impulse_time -= delta
		velocity.y += delta*GameConstants.GRAVITY
	
	if Input.is_action_pressed("jump") and jump_impulse_time > 0:
		velocity.y -= delta*JUMP_FORCE
	
	move_and_slide()
	
	if global_position.y > GameConstants.DEATH_GLOBAL_Y_POSITION:
		hurt(1000)
	
	if pistol_target == null or pistol_target.dead:
		select_target()
	var where = pistol_target.global_position if pistol_target != null else Vector2.RIGHT
	aim_to(where, delta)

func hurt(damage: float):
	if randi() % 100 <= evasion:
		return
	life_points -= damage
	$UI.sync_life(life_points, max_life_points)
	if life_points <= 0:
		die()

func die():
	died.emit()

func shoot():
	var orientation = $ShoulderPivot.rotation
	var game = get_tree().current_scene
	game.spawn_bullet($ShoulderPivot.global_position + Vector2.from_angle(orientation)*120, orientation, true)

func select_target():
	pistol_target = null
	var pistol_range = 1000
	for enemy: Node2D in get_tree().get_nodes_in_group("enemies"):
		if (enemy.global_position - global_position).length() < pistol_range:
			pistol_target = enemy

func aim_to(location: Vector2, delta: float):
	var target_orientation = $ShoulderPivot.global_position.angle_to_point(location)
	var rotation_strength = fmod(target_orientation-$ShoulderPivot.rotation, PI)/PI
	$ShoulderPivot.rotation += rotation_strength*arm_rotation_speed*delta

func get_xp(amount: int):
	xp += amount
	if(xp >= xp_threshold):
		xp -= xp_threshold
		await level_up()
	get_tree().paused = false

func level_up():
	get_tree().paused = true
	$UI/LevelUpScreen.pick_powerup()
	var powerup = await $UI/LevelUpScreen.powerup_selected
	get_tree().paused = false
	level += 1
	xp_threshold = level*1000
	equip_powerup(powerup)

func equip_powerup(powerup_name: String):
	var powerup = GameLibrary.POWERUPS[powerup_name]
	if not powerups.has(powerup_name):
		powerups[powerup_name] = 1
		if powerup["type"] == GameLibrary.PowerUpType.Weapon:
			var weapon_instance = powerup.scene.instantiate()
			add_child(weapon_instance)
	else:
		powerups[powerup_name] += 1
	
	if powerup["type"] == GameLibrary.PowerUpType.Passive:
		match powerup_name:
			'Armor':
				max_life_points += 20
				life_points += 20
				$UI.sync_life(life_points, max_life_points)
			"Invisibility cloak":
				evasion += 5
			'Bad coffee':
				attack_frecuency_boost += 0.2
				get_tree().call_group("weapos", "cooldown_boost", attack_frecuency_boost)
				$ShootingCooldown.wait_time = shooting_cooldown/attack_frecuency_boost
			'Dark Necrogrimoire':
				life_steal += 0.05

func steal_life(damage: float):
	var life_stealed = life_steal*damage
	life_points = min(max_life_points, life_points+life_stealed)
	$UI.sync_life(life_points, max_life_points)

func _on_enermy_defeated(who: Variant) -> void:
	get_xp(who.xp_value)
