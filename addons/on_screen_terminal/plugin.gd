@tool
extends EditorPlugin

const SINGLETON_NAME = "OnScreenTerminal"

func _enter_tree() -> void:
	add_autoload_singleton(SINGLETON_NAME, "res://addons/on_screen_terminal/on_screen_terminal.tscn")
	ProjectSettings.set_setting("on_screen_terminal/size", Vector2(400, 200))
	ProjectSettings.set_setting("on_screen_terminal/enabled", true)


func _exit_tree() -> void:
	ProjectSettings.clear("on_screen_terminal/size")
	ProjectSettings.clear("on_screen_terminal/enabled")
	remove_autoload_singleton(SINGLETON_NAME)

