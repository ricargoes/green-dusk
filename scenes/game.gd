extends Node2D

@export
var run_time: float = 300.0

const ANIMATION_BASE_RUNTIME: float = 300.0

func _ready() -> void:
	$SunsetAnimator.speed_scale = ANIMATION_BASE_RUNTIME/run_time
	$SunsetTime.start(run_time)
	

func spawn_bullet(starting_position: Vector2, orientation: float, is_player: bool):
	var bullet = PoolManager.get_instance(PoolManager.PoolResource.BULLET)
	bullet.global_position = starting_position
	bullet.orientation = orientation
	bullet.is_player = is_player
	$Bullets.add_child(bullet)

func win() -> void:
	get_tree().paused = true
	$CanvasLayer/SunsetTint.color = Color("ff010000")
	$CanvasLayer/EndScreen.show_win()
	await $CanvasLayer/EndScreen.game_restarted
	get_tree().paused = false
	get_tree().reload_current_scene()

func lose() -> void:
	get_tree().paused = true
	$CanvasLayer/SunsetTint.color = Color("ff010000")
	$CanvasLayer/EndScreen.show_lose(run_time - $SunsetTime.time_left)
	await $CanvasLayer/EndScreen.game_restarted
	get_tree().paused = false
	get_tree().reload_current_scene()
