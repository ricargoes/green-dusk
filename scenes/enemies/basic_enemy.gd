extends Enemy

@export
var speed: int = 200

func _on_reasses_dir_cooldown_timeout() -> void:
	randomize()
	var dir = (randi() % 2 - 0.5)*2
	velocity.x = speed*dir
	$Sprite2D.scale.x = 1 if dir < 0 else -1

func _custom_entry_behaviour():
	_on_reasses_dir_cooldown_timeout()
