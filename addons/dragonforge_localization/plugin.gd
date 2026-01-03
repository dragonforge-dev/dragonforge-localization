@tool
extends EditorPlugin


const AUTOLOAD_LOCALIZATION = "Localization"


func _enable_plugin() -> void:
	add_autoload_singleton(AUTOLOAD_LOCALIZATION, "res://addons/dragonforge_localization/localization.tscn")


func _disable_plugin() -> void:
	remove_autoload_singleton(AUTOLOAD_LOCALIZATION)
