extends Node

enum PoolResource {
	BULLET,
	BASIC_ENEMY,
}

const resources_scenes = {
	PoolResource.BULLET: preload("res://scenes/bullet.tscn"),
	PoolResource.BASIC_ENEMY: preload("res://scenes/enemies/enermy.tscn"),
}

var pool: Dictionary = {}

func _ready() -> void:
	for resource in PoolResource.values():
		pool[resource] = []

func get_instance(resource_type: PoolResource) -> Node2D:
	var instance: Node2D = pool[resource_type].pop_back()
	if instance == null:
		instance = resources_scenes[resource_type].instantiate()
	instance.set_process(true)
	instance.show()
	return instance 

func shelf_instance(instance: Node2D):
	var resource_type: PoolResource = instance.resource_type
	instance.get_parent().remove_child(instance)
	exile_instance(instance)
	pool[resource_type].append(instance)

func exile_instance(instance: Node2D):
	instance.global_position = Vector2(-10000, -1000)
	instance.hide()
	instance.set_process(false)
