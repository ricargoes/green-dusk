class_name Spawner extends Marker2D

@export
var spawning_resource: PoolManager.PoolResource = PoolManager.PoolResource.FLYING_ENEMY
@export
var spawning_frequency_by_level: Dictionary = {
	1: 2.0,
	2: 6.0,
	3: 10.0,
	4: 14.0,
	5: 20.0
}
@export
var lifetime: float = 1.0
@export
var destination: Node2D = null
@export
var activator: Area2D = null

var velocity: Vector2

func _ready() -> void:
	disable()
	if activator != null:
		activator.body_entered.connect(enable)

func _process(delta: float) -> void:
	position += velocity*delta

func enable(_by_who = null):
	var game = get_tree().current_scene
	
	$SpawningCooldown.start(1.0/spawning_frequency_by_level[game.difficulty_level])
	if lifetime > 0:
		$Lifetime.start(lifetime)
	velocity = Vector2.ZERO if destination == null else (destination.global_position - global_position)/lifetime
	set_process(true)

func disable():
	$SpawningCooldown.stop()
	set_process(false)

func spawn():
	var instance: Node2D = PoolManager.get_instance(spawning_resource)
	get_parent().add_child(instance)
	instance.global_position = global_position
	

func _on_activator_body_entered(_body: Node2D) -> void:
	enable()
