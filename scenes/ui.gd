extends CanvasLayer


func sync_life(actual_value: float, max_value: int):
	%LifeBar.max_value = max_value
	%LifeBar.value = actual_value

func sync_xp(actual_value: float, max_value: int):
	%XPBar.max_value = max_value
	%XPBar.value = actual_value

func update_deathcount(death_count: int):
	%DeathCount.text = str(death_count) + " enemies slain"
