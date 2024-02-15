extends CenterContainer

signal game_restarted

func show_win():
	%YouWin.text = "You Win"
	%WinDescription.text = "You managed to escape the hordes of daylight vampires till the sun was set. Now you are free and badass."
	show()

func show_lose(elapsed_time: float):
	%YouWin.text = "You Lose"
	%WinDescription.text = "The hordes of daylight vampires got to you after %d seconds of daring espace. Tough luck." % elapsed_time
	show()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_again_pressed() -> void:
	game_restarted.emit()
