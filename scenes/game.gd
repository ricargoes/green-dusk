extends Node2D

const BULLET_SCENE = preload("res://scenes/bullet.tscn")


func spawn_bullet(starting_position: Vector2, orientation: float, is_player: bool):
	var bullet = BULLET_SCENE.instantiate()
	bullet.global_position = starting_position
	bullet.orientation = orientation
	bullet.is_player = is_player
	$Bullets.add_child(bullet)


func _on_hero_shot(spawn_position: Vector2, orientation: float) -> void:
	spawn_bullet(spawn_position, orientation, true)
