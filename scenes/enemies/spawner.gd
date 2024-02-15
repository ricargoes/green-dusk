class_name Spawner extends Marker2D

@export
var spawning_resource: PoolManager.PoolResource = PoolManager.PoolResource.BASIC_ENEMY
@export
var spawning_frequency: float = 2.0

func enable():
	if $SpawningCooldown.is_stopped():
		$SpawningCooldown.start(1.0/spawning_frequency)
	
func disable():
	if not $SpawningCooldown.is_stopped():
		$SpawningCooldown.stop()

func spawn():
	var instance: Node2D = PoolManager.get_instance(spawning_resource)
	add_child(instance)
	instance.global_position = global_position
	


