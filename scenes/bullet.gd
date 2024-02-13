extends CharacterBody2D

@export
var is_player: bool = false
@export
var orientation: float = 0.0
@export
var bullet_speed: float = 1000
@export
var damage: float = 10.0

func _ready() -> void:
	collision_mask = 4
	if is_player:
		collision_mask += 2
	else:
		collision_mask += 1
	
	velocity = Vector2.from_angle(orientation)*bullet_speed

func _process(delta: float) -> void:
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.get_collider().has_method("hurt"):
			collision.get_collider().hurt(damage)
		
		queue_free()
