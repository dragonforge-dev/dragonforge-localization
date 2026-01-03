@icon("res://addons/dragonforge_localization/assets/textures/icons/localization_button.svg")
## OptionButton that automatically loads all available localized translations
## for your game and allows you to switch between locales them in the game.
## Also handles saving what language was saved and ensuring the game continues
## to use that language between sessions.
class_name LocalizationButton extends OptionButton

enum FlagSize { 
	## 16x10 pixel flags.
	SIZE_16_X_10,
	## 24x16 pixel flags.
	SIZE_24_X_16, 
	## 48x32 pixel flags.
	SIZE_48_X_32,
	## 64x42 pixel flags.
	SIZE_64_X_42,
	## 96x64 pixel flags.
	SIZE_96_X_64 ,
	}
enum TextType { 
	## Show no text next to the flag.
	NONE,
	## Show the 2-letter language code next to the flag.
	LANGUAGE_CODE,
	## Show the full name of the language
	LANGUAGE_NAME,
	## Show the 2-letter couuntry code next to the flag.
	COUNTRY_CODE,
	## Show the full country name
	COUNTRY_NAME,
	}

const flag_folder = {
	FlagSize.SIZE_16_X_10: "res://addons/dragonforge_localization/assets/textures/flags/16x10/",
	FlagSize.SIZE_24_X_16: "res://addons/dragonforge_localization/assets/textures/flags/24x16/",
	FlagSize.SIZE_48_X_32: "res://addons/dragonforge_localization/assets/textures/flags/48x32/",
	FlagSize.SIZE_64_X_42: "res://addons/dragonforge_localization/assets/textures/flags/64x42/",
	FlagSize.SIZE_96_X_64: "res://addons/dragonforge_localization/assets/textures/flags/96x64/",
}

## The size of the flags to show. The second number should correspond as closely
## as possible to the font size for the best appearance.
@export var flag_size: FlagSize = FlagSize.SIZE_24_X_16
## The text to show next to the flag options.
@export var text_type: TextType = TextType.LANGUAGE_NAME
## Capitalize the text displayed next to the flag in the selections.
@export var capitalize_text: bool = true
## If true, this will override the theme font size to match the flags' size.
@export var match_text_size: bool = true


func _ready() -> void:
	_load_flag_icons()
	var localization_language: Variant = Disk.load_setting("localization_language")
	if localization_language:
		_on_locale_changed(localization_language)
	Localization.locale_changed.connect(_on_locale_changed)
	item_selected.connect(_on_item_selected)
	if match_text_size:
		var text: String = FlagSize.find_key(flag_size)
		var new_font_size: int = int(text.substr(text.length() - 2)) # Get the last two characters and convert them to an int
		add_theme_font_size_override("font_size", new_font_size)


func _on_item_selected(index: int) -> void:
	var locale = Localization.available_localizations[index]
	#var locale: String = get_item_text(index)
	print("Current Locale: %s   Passed Locale: %s" % [TranslationServer.get_locale(), locale])
	if TranslationServer.get_locale() != locale:
		TranslationServer.set_locale(locale)
		Localization.locale_changed.emit(locale)
	Disk.save_setting(locale, "localization_language")


func _on_locale_changed(new_locale: String) -> void:
	if new_locale:
		for i in range(Localization.available_localizations.size()):
			if new_locale == Localization.available_localizations[i]:
				select(i)
				break


func _load_flag_icons() -> void:
	var current_selection = get_selected_id()
	clear()

	for locale: String in Localization.available_localizations:
		var texture: Texture2D = load(flag_folder[flag_size] + Localization.get_country_code(locale) + ".png")
		var display_text: String
		match text_type:
			TextType.LANGUAGE_CODE:
				display_text = Localization.get_language_code(locale)
			TextType.LANGUAGE_NAME:
				display_text = TranslationServer.get_language_name(Localization.get_language_code(locale))
			TextType.COUNTRY_CODE:
				display_text = Localization.get_country_code(locale).to_lower()
			TextType.COUNTRY_NAME:
				display_text = TranslationServer.get_country_name(Localization.get_country_code(locale))
			TextType.NONE:
				display_text = ""
		if capitalize_text:
			display_text = display_text.to_upper()
		
		add_icon_item(texture, display_text)

	# If the user has never selected a language preference, we default to the
	# user's regional language if available, then fall back to whatever is set
	# in Project Settings > Internationalization > Locale, and then finally fall
	# back on "en_US".
	if current_selection == -1:
		var preferred_language: String = OS.get_locale_language()
		if preferred_language == "en":
			preferred_language = "en_US"
		_on_locale_changed(preferred_language)
	else:
		select(current_selection)
