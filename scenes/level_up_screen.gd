extends CenterContainer

const MAX_WEAPONS = 4
const MAX_PASSIVES = 2

signal powerup_selected(powerup_name)

func pick_powerup(powerup_levels: Dictionary) -> bool:
	for node in %Options.get_children():
		node.queue_free()
	
	var weapon_count = 0
	var passive_count = 0
	for owned_powerup in powerup_levels:
		var powerup_info = GameLibrary.POWERUPS[owned_powerup]
		if powerup_info["type"] == GameLibrary.PowerUpType.Weapon:
			weapon_count += 1
		elif powerup_info["type"] == GameLibrary.PowerUpType.Passive:
			passive_count += 1
	
	var all_powerups: Array = GameLibrary.POWERUPS.keys()
	var available_powerups = all_powerups.duplicate()
	for powerup_name in all_powerups:
		var powerup_info = GameLibrary.POWERUPS[powerup_name]
		if weapon_count >= MAX_WEAPONS and powerup_info["type"] == GameLibrary.PowerUpType.Weapon and not powerup_levels.has(powerup_name):
			available_powerups.erase(powerup_name)
			continue
		if passive_count >= MAX_PASSIVES and powerup_info["type"] == GameLibrary.PowerUpType.Passive and not powerup_levels.has(powerup_name):
			available_powerups.erase(powerup_name)
			continue
		var level = powerup_levels.get(powerup_name, 0)
		if level >= 5:
			available_powerups.erase(powerup_name)
			continue
	
	if available_powerups.is_empty():
		return false
	
	show()
	randomize()
	var count = 0
	var ramaining_powerups = available_powerups.duplicate()
	while count < min(3, available_powerups.size()):
		var powerup_name = ramaining_powerups.pop_at(randi() % ramaining_powerups.size())
		var powerup_info = GameLibrary.POWERUPS[powerup_name]
		var button = Button.new()
		button.icon = powerup_info['icon']
		button.text = "{name}\n{description}".format({'name': powerup_name, 'description': powerup_info['description']})
		button.pressed.connect(powerup_clicked.bind(powerup_name))
		%Options.add_child(button)
		count += 1
	return true

func powerup_clicked(powerup_name: String):
	powerup_selected.emit(powerup_name)
	hide()
