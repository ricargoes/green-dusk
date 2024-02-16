extends Enemy

@export
var wander_upper_limit: float =  200
@export
var wander_lower_limit: float =  500
@export
var wander_speed := Vector2(-300, 200)
@export
var attack_speed: float = 300
@export
var attack_range: int = 500

func _process(delta: float) -> void:
	var hero: Node2D = get_tree().get_first_node_in_group("hero")
	var distance_to_hero = hero.global_position - global_position
	if distance_to_hero.length() < attack_range:
		velocity = distance_to_hero.normalized()* attack_speed
	else:
		wander_speed.y *= -1 if (global_position.y < wander_upper_limit and wander_speed.y < 0) or (global_position.y > wander_lower_limit and wander_speed.y > 0)  else 1
		velocity = wander_speed
	
	move_and_slide()
	
	fall_check()
	contact_attack(delta)
