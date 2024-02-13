extends CanvasLayer

var enabled = true

func _ready() -> void:
	var size: Vector2 = ProjectSettings.get_setting("on_screen_terminal/size", Vector2(400, 200))
	$Terminal.custom_minimum_size = size
	enabled = ProjectSettings.get_setting("on_screen_terminal/enabled", true)
	if not enabled:
		hide()

func log(message: Variant) -> void:
	if enabled:
		$Terminal.text += "\n> " + str(message)
		$Terminal.get_v_scroll_bar().value = $Terminal.get_v_scroll_bar().max_value
	
	
