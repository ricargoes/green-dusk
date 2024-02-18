extends Node2D

@export
var run_time: float = 300.0

const ANIMATION_BASE_RUNTIME: float = 300.0
const TERRAIN_CHUNK_LENGTH: int = 6*1920
const TERRAINS_SCENES = [
	preload("res://scenes/terrain/terrain_chunk_1.tscn"),
	preload("res://scenes/terrain/terrain_chunk_2.tscn"),
	preload("res://scenes/terrain/terrain_chunk_3.tscn"),
	preload("res://scenes/terrain/terrain_chunk_4.tscn"),
]
var last_terrain_position := Vector2.ZERO

func _ready() -> void:
	$SunsetAnimator.speed_scale = ANIMATION_BASE_RUNTIME/run_time
	$SunsetTime.start(run_time)

func _process(_delta: float) -> void:
	if $Hero.position > last_terrain_position:
		var terrain = TERRAINS_SCENES[randi() % TERRAINS_SCENES.size()].instantiate()
		last_terrain_position += Vector2(TERRAIN_CHUNK_LENGTH, 0)
		terrain.position = last_terrain_position
		$Terrain.add_child(terrain)
		for terrain_chunk: Node2D in $Terrain.get_children():
			if $Hero.position.x - terrain_chunk.position.x >  2*TERRAIN_CHUNK_LENGTH:
				terrain_chunk.queue_free()
	
func spawn_bullet(starting_position: Vector2, orientation: float, is_player: bool, lifetime: float = 1):
	var bullet = PoolManager.get_instance(PoolManager.PoolResource.BULLET)
	bullet.global_position = starting_position
	bullet.orientation = orientation
	bullet.is_player = is_player
	bullet.bullet_lifetime = lifetime
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
