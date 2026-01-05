[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.5.stable-blue?style=plastic&logo=godotengine)](https://godotengine.org/)
[![License](https://img.shields.io/github/license/dragonforge-dev/dragonforge-localization?logo=mit)](https://github.com/dragonforge-dev/dragonforge-localization/blob/main/LICENSE)
[![GitHub release badge](https://badgen.net/github/release/dragonforge-dev/dragonforge-localization/latest)](https://github.com/dragonforge-dev/dragonforge-localization/releases/latest)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-localization)](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-localization)

# Dragonforge Localization <img src="/assets/textures/readme/project_icon.svg" width="32" alt="Project Icon"/>
Godot plugin that automatically loads all available localized translations and provides an OptionButton that allows you to switch between them in the game, saving state between sessions.

Localization is simply the process of making your game playable in another country. For most games that typically means translation of text into other languages. This plugin leverages Godot's already robust localization tools.

# Version 0.1.1
For use with **Godot 4.5.stable** and later.
## Dependencies
The following dependencies are included in the addons folder and are required for the template to function.
- [Dragonforge Disk (Save/Load) 0.6](https://github.com/dragonforge-dev/dragonforge-disk)
# Installation Instructions
1. Copy the `dragonforge_localization` folder from the `addons` folder into your project's `addons` folder.
2. If it does not exist already, copy the `dragonforge_disk` folder from the `addons` folder into your project's `addons` folder.
3. In your project go to **Project -> Project Settings...**
4. Select the **Plugins** tab.
5. Check the **On checkbox** under **Enabled** for **Dragonforge Disk (Save/Load)**
6. Check the **On checkbox** under **Enabled** for **Dragonforge Localization**
7. Press the **Close** button.

# Usage Instructions
The localization button automatically pulls a list of supported languages from the folder your localization csv file is located. These instructions will walk you through creating that file and using it.

## Creating Localization Files
First, we have to create the localization files. It seems like a lot, but it's quite simple, and once we are done, it's really easy to add new translations.

### Creating a Google Docs Sheet
To create the CSV, we will be using Google Docs. You can use any program, even a text editor like Notepad to create a CSV. We are using Google Docs because it has a translation Macro, allowing you to support languages you do not know.
1. Go to [https://drive.google.com/](https://drive.google.com/) (*Login with your gmail account or create onw if you do not have one.*)
2. Click the **+ New** button in the upper left-hand corner.
3. Select **Google Sheets** from the drop down.
4. Click **Untitled spreadsheet** at the top of the new sheet and name it your game's name in all lowercase letters. (*It doesn't actually matter what the file is called so use whatever you want. However having it all lowercase does matter if you're exporting to Windows.*)
5. Click the **Down Arrow** next to **Sheet1** at the bottom of the screen.
6. Select **Rename** from the pop-up menu.
7. Change the sheet name to `localization`. (*This is just convention. It doesn't actually matter what the sheet is called. It will just make things clearer when the file is in your project. However having it all lowercase does matter if you're exporting to Windows.*)

<img src="/assets/textures/readme/creating_sheet.png" width="600" alt="Creating Spreadsheet Screen Shot"/>

### Creating Headers
We are going to create translations for 8 languages, including two version of english and french each to show how to do the same language from different countries. The first step is to create a column in our spreadsheet for each language or language/country combo that we want to support. **NOTE:** If your native language is not English, add your native language as a column. (*More on this later.*)
1. In Cell **A1** type `keys`.
2. In cell **B1** type `en-US`. (English, American) NOTE: This is the default language for Godot.
3. In cell **C1** type `en-GB`. (English, Great Britain)
4. In cell **D1** type `fr`. (French)
5. In cell **E1** type `fr-CA`. (French, Canadian)
6. In cell **F1** type `de`. (German)
7. In cell **G1** type `ko-KR`. (Korean, Korean)
8. In cell **H1** type `ja-JP`. (Japanese, Japan)
9. In cell **I1** type `zh-CN`. (Chinese, China)

You will note that some countries have both a language code and a country code. In this context we will primarily use the country code to show the appropriate country flag, but we will also use the distinction for spelling differences between regions.

<img src="/assets/textures/readme/headers.png" width="600" alt="Creating Headers"/>

### Creating Keys
Godot offers the ability to easily replace any **Label** or **Button** text in `ALL_CAPS` with a localizzed (translated) version of that string. So we are going to use some words that are different in American English and British English, and some that are differnt between European French and Canadian French. 
1. In Cell **A2** type `COLOR`.
2. In Cell **A3** type `ARMOR`.
3. In Cell **A4** type `CAR`.
4. In Cell **A5** type `ENJOYMENT_PHRASE`.
5. In Cell **A6** type `SCORE`.

<img src="/assets/textures/readme/keys.png" width="600" alt="Creating Keys"/>

### Creating Words to Translate
In the previous section, we created the keys we are going to use. In this section, we are going to create the actual words replacing those strings in our native language. We are assuming your native language is English, or that you will be translating from English. If you would like to use your native language and translate from that, fill out that column instead as we go through.
1. In Cell **B2** type `Color`.
2. In Cell **B3** type `Armor`.
3. In Cell **B4** type `Car`.
4. In Cell **B5** type `It's fun!`.
6. In Cell **B6** type `SCORE`.

<img src="/assets/textures/readme/english.png" width="600" alt="American English Translation"/>

### Translating The Sheet
Now that we have column B filled out (*or your native language*), we can start translating. We are going to use the `GOOGLETRANSLATE()` macro that Google Sheets provides.
1. In Cell **C2** type `=GOOGLETRANSLATE($B2,"en",C$1)` and press **Enter**.
2. Select Cell **C2** so that it is outlined in blue and has a blue circle in the lower right-hand corner of the cell.
3. Click the blue circle and drag it to cell **C6**.
4. Let go. The C column cells will all be filled in.
5. With cells **C2** to **C6** all selected, click the blue circle again and drag it to cell **I6**.
6. Let go. All the cells will be be filled in.

There are going to be errors. We will fix them in the next section.

**NOTE:** If you want to translate from a different language, you can replace `en` with your language code, or you can replace it with `auto` to have it detect the language. To change what column it translates from, change the `B` in `$B2` to the clomun letter you want to translate from.

<img src="/assets/textures/readme/translation.png" width="600" alt="Translation Macro"/>

### Fixing Translation Errors
Unfortunately, Google Translate does not yet support regional dialect transformation. So we will have to do it ourselves and fix the errors for Candian French.
1. In Cell **C2** type `Colour`.
2. In Cell **C3** type `Armour`.
3. In Cell **C2** type `It's brilliant!`.
4. In Cell **E2** type `=GOOGLETRANSLATE($B2,"en","fr")` and press **Enter**.
5. Select Cell **E2** so that it is outlined in blue and has a blue circle in the lower right-hand corner of the cell.
6. Click the blue circle and drag it to cell **E6**.
7. Let go. The E column cells will all be filled in and the errors will disappear.
8. In Cell **E4** type `Char`. (*Because in Canadian French the word for car is different.*)
9. In Cell **E5** type `C'est amusant!`. (*Because in Canadian French there is no space between the sentence and exclamation point.*)
10. In Cell **D5** type `C'est le fun !`. (*Because in France there is a specific idiom.*)

As you can see, we can add in answers when we have better ones, or when someone else points out a better translation.

<img src="/assets/textures/readme/fixing_errors.png" width="600" alt="Fixing Errors"/>

### Creating a Localization Folder
Godot doesn't care where you store your localizations, so it's up to you to decide what to call the folder and where to put it in your project.
1. In the Godot editor, create a new folder to store the localization data. (We use `res://assets/localization/`.)
2. Open `res://addons/dragonforge_localization/localization.tscn`.
3. In the **Inspector** click the **Folder** icon next to **Localization Folder**.
4. Browse to the folder you created and press the **Select Current Folder** button.

**NOTE:** Steps 2 to 4 are for this plugin and are actually needed for the CSV file to load. Godot will detect it wherever it is located in your project.

### Importing the CSV
Now that we have our file complete and a place to put it, we can save and import it. Any time we make changes to the file, either adding rows or updating translations, we can just follow these steps again.
1. In Google Sheets, go to **File -> Download** and select **Comma Separated Valuse (.csv)**
2. Drag and drop the downloaded CSV file from your downloads folder into your project's localization folder.
3. Wait for the localization files to be created.

**NOTE:** There is another step to setting up localizations if you do not use the plugin, but that is automated by the **Localization** plugin. To learn how to do it manually, check out the documentation links in the [More Reading](#-more-reading) section.

## Using the Localization Button <img src="/addons/dragonforge_localization/assets/textures/icons/localization_button.svg" width="32" alt="Localization Button Icon"/>
The **LocalizationButton** node is an **Option Button** that can be added just like any **Control** node.
1. Open/Create a scene you where want to add the node.
2. Click the **+ (Add Child Node)** button or press **Ctrl + A**.
3. Select the newly added **LocalizationButton** node.
4. In the **Inspector**, select the size of the flags you want.
5. In the **Inspector**, add a **Theme** or edit **Theme Overrides** to customize your button and the font used.

### BONUS: Translating the Button Options
When you select a language, if you have either the language name (default) or country name showing, it's still in english. We can change that by adding more rows to our translation file like so:

<img src="/assets/textures/readme/translating_button_options.png" width="600" alt="Translating the Button Options"/>

Then just make sure the **Capitalize Text** option is selected for the language selection button(s) and they will be automatically translated.

## Conclusion
You can see a full example of the completed CSV in `res://test/assets/localization/dragonforge plugin - localization.csv`, which you can load up in Google Sheets. To see the button at work in this project, just set the **Localization Folder** in the **Localization** autoload scene (`res://addons/dragonforge_localization/localization.tscn`) to `res://test/assets/localization/` and then press the **Run Project** button (**F5**).

# Class Descriptions

## Localization (Autoload) <img src="/assets/textures/readme/location.svg" width="32" alt="Localization Icon"/>
This autoload handles the heavy lifting of setting up localization for you when the game starts.
### Signals
- `locale_changed(new_locale: String)` Signal to use when changing localization by using TranslationServer.set_locale(new_locale)
### Export Variables
- `localization_folder: String` The folder where the translations are stored. (**NOTE:** This must be set or your game will not run.)
### Public Variables
- `available_localizations: Array[String]` Contains all the available localizations once the game is running.
### Public Functions
- `get_country_code(locale: String) -> String` Returns uppercase 2-letter country code of the passed locale if it exists, otherwise returns the language code.
- `get_language_code(locale: String) -> String` Returns lowercase 2-letter or 3-letter language code of the passed locale.

## LocalizationButton <img src="/addons/dragonforge_localization/assets/textures/icons/localization_button.svg" width="32" alt="Localization Icon"/>
OptionButton that automatically loads all available localized translations for your game and allows you to switch between locales them in the game. Also handles saving what language was saved and ensuring the game continues to use that language between sessions.
### Enums
- FlagSize
	- `SIZE_16_X_10` 16x10 pixel flags.
	- `SIZE_24_X_16` 24x16 pixel flags.
	- `SIZE_48_X_32` 48x32 pixel flags.
	- `SIZE_64_X_42` 64x42 pixel flags.
	- `SIZE_96_X_64` 96x64 pixel flags.
- TextType
	- `NONE` Show no text next to the flag.
	- `LANGUAGE_CODE` Show the 2-letter language code next to the flag.
	- `LANGUAGE_NAME` Show the full name of the language
	- `COUNTRY_CODE` Show the 2-letter couuntry code next to the flag.
	- `COUNTRY_NAME` Show the full country name
### Export Variables
- `flag_size: FlagSize = FlagSize.SIZE_24_X_16` The size of the flags to show. The second number should correspond as closely as possible to the font size for the best appearance.
- `text_type: TextType = TextType.LANGUAGE_NAME` The text to show next to the flag options.
- `capitalize_text: bool = true` Capitalize the text displayed next to the flag in the selections.
- `match_text_size: bool = true` If true, this will override the theme font size to match the flags' size.


# More Reading
- [GoTut Localization Tutorial](https://www.gotut.net/localization-in-godot-4/) - The original tutorial used to develop this plugin.
- [Importing Translations](https://docs.godotengine.org/en/4.4/tutorials/assets_pipeline/importing_translations.html) - Godot documentation on using the translation csv file.
- [Internationalizing (Localizing) Games](https://docs.godotengine.org/en/stable/tutorials/i18n/internationalizing_games.html) - Godot documentation on how to set up localization. Includes a deepr dive on additionla features and an example project.

# Copyright
All art included in this plugin can be freely used for free and commercial projects.

## Icons
- [Location Icon](https://www.svgrepo.com/svg/33955/location) from SVG Repo (CC0 License).
- [Global Localization Icon](https://www.svgrepo.com/svg/53904/global-localization) from SVG Repo (CC0 License).

## Localization Flags
[World Country Flags Pack](https://moxica.itch.io/country-flags-icons) by [Moxica](https://moxica.itch.io/) **License:** You can use or modify the graphic assets according to your need for your projects (both commercial and personal). **You may not redistribute them or resell them.**
