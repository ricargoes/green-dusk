extends CharacterBody2D

const JUMP_FORCE = 3000
const MAX_JUMP_IMPULSE_TIME: float = 0.3

@export
var player_speed: int = 200

@export
var max_life_points: int = 50
@export 
var life_boost: float = 0.0
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
var enemies_slain: int = 0

var jump_impulse_time: float = 0.0

signal died

func _ready() -> void:
	life_points = max_life_points + life_boost
	$UI.sync_life(life_points, max_life_points + life_boost)
	$UI.sync_xp(xp, xp_threshold)
	level_up()

func _process(delta: float) -> void:
	velocity.x = player_speed
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
	
func hurt(damage: float):
	if randi() % 100 <= evasion:
		return
	life_points -= damage
	$UI.sync_life(life_points, max_life_points + life_boost)
	if life_points <= 0:
		die()

func die():
	died.emit()

func get_xp(amount: int):
	xp += amount
	if(xp >= xp_threshold):
		xp -= xp_threshold
		await level_up()
	$UI.sync_xp(xp, xp_threshold)
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
		powerups[powerup_name] = 0
		
	powerups[powerup_name] += 1
	
	if powerup["type"] == GameLibrary.PowerUpType.Passive:
		var boost_value = powerup['levels'][powerups[powerup_name]]
		match powerup_name:
			'Armor':
				life_boost = boost_value
				life_points += 20
				$UI.sync_life(life_points, max_life_points + life_boost)
			"Invisibility cloak":
				evasion = boost_value
			'Bad coffee':
				attack_frecuency_boost = boost_value/100.0
				get_tree().call_group("weapons", "cooldown_boost", attack_frecuency_boost)
			'Dark Necrogrimoire':
				life_steal = boost_value/100.0
	elif powerup["type"] == GameLibrary.PowerUpType.Weapon:
		if powerups[powerup_name] == 1:
			var weapon_instance = powerup.scene.instantiate()
			weapon_instance.name = powerup_name
			add_child(weapon_instance)
		
		get_node(powerup_name).set_level(powerups[powerup_name])
	%Summary.sync_powerups(powerups)

func steal_life(damage: float):
	var life_stealed = life_steal*damage
	life_points = min(max_life_points, life_points+life_stealed)
	$UI.sync_life(life_points, max_life_points)

func on_enermy_defeated(enermy: Enemy) -> void:
	get_xp(enermy.xp_value)
	enemies_slain += 1
