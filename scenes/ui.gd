extends CanvasLayer


func sync_life(actual_value: float, max_value: int):
	%LifeBar.max_value = max_value
	%LifeBar.value = actual_value
