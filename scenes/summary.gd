extends ItemList


func sync_powerups(powerups_levels: Dictionary):
	clear()
	for powerup_name in powerups_levels.keys():
		var powerup_info: Dictionary = GameLibrary.POWERUPS[powerup_name]
		var level: int = powerups_levels[powerup_name]
		add_item(powerup_name + ": Level " + str(level), powerup_info['icon'], false)
