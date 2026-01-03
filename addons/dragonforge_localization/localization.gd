@icon("res://addons/dragonforge_localization/assets/textures/icons/localization.svg")
extends Node

## Signal to use when changing localization by using TranslationServer.set_locale(new_locale)
signal locale_changed(new_locale: String)

## The folder where the translations are stored.
@export_dir var localization_folder: String

## Contains all the available localizations once the game is running.
var available_localizations: Array[String]

func _ready() -> void:
	if not localization_folder:
		assert(false, "A Localization Folder has not been set in the Localization plugin. The Localization button will not work correctly without this value set. Open res://addons/dragonforge_localization/localization.tscn and set the folder in the Inspector.")
	var loaded_locale: Variant = Disk.load_setting("localization_language")
	print("Loaded Language: %s" % loaded_locale)
	if loaded_locale:
		TranslationServer.set_locale(loaded_locale)
		print(TranslationServer.get_locale())
	_load_localizations()


## Returns uppercase 2-letter country code of the passed locale if it exists,
## otherwise returns the language code.
func get_country_code(locale: String) -> String:
	return locale.substr(locale.length() - 2).to_upper()


## Returns lowercase 2-letter or 3-letter language code of the passed locale.
func get_language_code(locale: String) -> String:
	return locale.replace("-", "_").get_slice("_", 0).to_lower()


func _load_localizations() -> void:
	var dir: DirAccess = DirAccess.open(localization_folder)
	if not dir:
		return
	var file_list: PackedStringArray = dir.get_files()
	for file_name: String in file_list:
		if file_name.ends_with(".translation"):
			var translation: Translation = load(localization_folder + "/" + file_name)
			TranslationServer.add_translation(translation) # Add the translation
			var locale = file_name.trim_suffix(".translation") # Trim the file suffix
			locale = locale.substr(locale.rfind(".") + 1, locale.length()) # Get the full language and locale if available
			available_localizations.append(locale)
