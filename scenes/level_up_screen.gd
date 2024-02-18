extends CenterContainer

signal powerup_selected(powerup_name)

func pick_powerup(powerup_levels: Dictionary):
	show()
	for node in %Options.get_children():
		node.queue_free()
	
	var available_powerups = GameLibrary.POWERUPS.keys()
	for powerup_name in available_powerups:
		var level = powerup_levels.get(powerup_name, 0)
		if level >= 5:
			available_powerups.erase(powerup_name)
	
	if available_powerups.is_empty():
		powerup_clicked("")
	
	randomize()
	var count = 0
	while count < min(3, available_powerups.size()):
		var powerup_name = available_powerups.pop_at(randi() % available_powerups.size())
		var powerup_info = GameLibrary.POWERUPS[powerup_name]
		var button = Button.new()
		button.icon = powerup_info['icon']
		button.text = "{name}\n{description}".format({'name': powerup_name, 'description': powerup_info['description']})
		button.pressed.connect(powerup_clicked.bind(powerup_name))
		%Options.add_child(button)
		count += 1

func powerup_clicked(powerup_name: String):
	powerup_selected.emit(powerup_name)
	hide()
