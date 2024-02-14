extends CenterContainer

signal powerup_selected(powerup_name)

func _ready() -> void:
	pick_powerup()

func pick_powerup():
	show()
	for node in %Options.get_children():
		node.queue_free()
	
	var available_powerups = GameLibrary.POWERUPS.keys()
	randomize()
	for _i in range(3):
		var powerup_name = available_powerups.pop_at(randi() % available_powerups.size())
		var powerup_info = GameLibrary.POWERUPS[powerup_name]
		var button = Button.new()
		button.icon = powerup_info['icon']
		button.text = "{name}\n{description}".format({'name': powerup_name, 'description': powerup_info['description']})
		button.pressed.connect(powerup_clicked.bind(powerup_name))
		%Options.add_child(button)

func powerup_clicked(powerup_name: String):
	powerup_selected.emit(powerup_name)
	hide()
