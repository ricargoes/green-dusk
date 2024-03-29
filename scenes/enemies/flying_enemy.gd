extends Enemy

const TOO_CLOSE_RANGE = 100

@export
var wander_upper_limit: float =  200
@export
var wander_lower_limit: float =  500
@export
var wander_speed := Vector2(-300, 200)
@export
var attack_speed: float = 550
@export
var attack_range: int = 500

var is_dumb: bool = false

func _custom_entry_behaviour():
	is_dumb = randi() % 3 == 0
	
func _process(delta: float) -> void:
	if not is_inside_tree():
		return
	var hero: Node2D = get_tree().get_first_node_in_group("hero")
	var distance_to_hero = hero.global_position - global_position
	var distance = distance_to_hero.length()
	if distance < attack_range and distance > TOO_CLOSE_RANGE and not is_dumb:
		velocity = distance_to_hero.normalized()* attack_speed
	else:
		wander_speed.y *= -1 if (global_position.y < wander_upper_limit and wander_speed.y < 0) or (global_position.y > wander_lower_limit and wander_speed.y > 0)  else 1
		wander_speed.x *= 1 if sign(distance_to_hero.x)*sign(velocity.x) > 0 else -1
		velocity = wander_speed
	$Sprite2D.scale.x = 1 if velocity.x < 0 else -1
	
	move_and_slide()
	
	fall_check()
	contact_attack(delta)
