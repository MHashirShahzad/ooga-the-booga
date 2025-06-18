@tool
extends EditorPlugin
const TRANSITION_MANAGER: StringName = "TransitionManager"

func _enable_plugin() -> void:
	print_rich("Adding TransitionManager autoload")
	if not Engine.has_singleton(TRANSITION_MANAGER):
		add_autoload_singleton(TRANSITION_MANAGER, "res://addons/transition_manager/transition_manager.tscn")

func _disable_plugin() -> void:
	remove_autoload_singleton(TRANSITION_MANAGER)
	
func _enter_tree():
	pass


func _exit_tree():
	pass
