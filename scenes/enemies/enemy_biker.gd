extends Enemy

@export
var speed: float = 800

func _process(delta: float) -> void:
	if not is_inside_tree():
		return
	var hero: Node2D = get_tree().get_first_node_in_group("hero")
	var distance_to_hero = hero.global_position - global_position
	if abs(distance_to_hero.x) > 20:
		velocity.x = sign(distance_to_hero.x)*speed
	if not is_on_floor():
		velocity.y += delta*GameConstants.GRAVITY
	$Sprite2D.scale.x = 1 if velocity.x > 0 else -1
	
	move_and_slide()
	
	fall_check()
	contact_attack(delta)
