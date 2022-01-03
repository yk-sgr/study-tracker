
/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 48 (24.0 per locale)
 *
 * Built on 2022-01-03 at 13:51 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
	en, // 'en' (base locale, fallback)
	de, // 'de'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn _t = _currLocale.translations;
_StringsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	/// Hint for pre 4.x.x developers: You can access the raw string via LocaleSettings.useDeviceLocale().languageTag
	static AppLocale useDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance?.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			return setLocaleRaw(deviceLocale);
		} else {
			return setLocale(_baseLocale);
		}
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_t = _currLocale.translations;

		if (WidgetsBinding.instance != null) {
			// force rebuild if TranslationProvider is used
			_translationProviderKey.currentState?.setLocale(_currLocale);
		}

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String localeRaw) {
		final selected = _selectLocale(localeRaw);
		return setLocale(selected ?? _baseLocale);
	}

	/// Gets current locale.
	/// Hint for pre 4.x.x developers: You can access the raw string via LocaleSettings.currentLocale.languageTag
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	/// Hint for pre 4.x.x developers: You can access the raw string via LocaleSettings.baseLocale.languageTag
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}

}

// context enums

// interfaces generated as mixins

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {
	_StringsEn get translations {
		switch (this) {
			case AppLocale.en: return _StringsEn._instance;
			case AppLocale.de: return _StringsDe._instance;
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.en: return 'en';
			case AppLocale.de: return 'de';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case AppLocale.de: return const Locale.fromSubtags(languageCode: 'de');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'en': return AppLocale.en;
			case 'de': return AppLocale.de;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _StringsEn translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

class _StringsEn {
	_StringsEn._(); // no constructor

	static final _StringsEn _instance = _StringsEn._();

	String get appName => 'Study Progress Tracker';
	String get appNameShort => 'Study Tracker';
	String get dateformat => 'MM/dd/yyyy';
	_StringsLoginPageEn get login_page => _StringsLoginPageEn._instance;
	_StringsHomePageEn get home_page => _StringsHomePageEn._instance;
	_StringsAddGoalPageEn get add_goal_page => _StringsAddGoalPageEn._instance;
	_StringsGoalViewPageEn get goal_view_page => _StringsGoalViewPageEn._instance;

	/// A flat map containing all translations.
	dynamic operator[](String key) => _translationMapEn[key];
}

class _StringsLoginPageEn {
	_StringsLoginPageEn._(); // no constructor

	static final _StringsLoginPageEn _instance = _StringsLoginPageEn._();

	String get google_button => 'Sign in with Google';
	String get anonymous_button => 'Continue without account';
	String get error => 'Could not log in';
}

class _StringsHomePageEn {
	_StringsHomePageEn._(); // no constructor

	static final _StringsHomePageEn _instance = _StringsHomePageEn._();

	String get fab => 'Add Goal';
	String get no_goals => 'No Goal.';
	String get error_loading_goals => 'An error occurred while loading your goals.';
}

class _StringsAddGoalPageEn {
	_StringsAddGoalPageEn._(); // no constructor

	static final _StringsAddGoalPageEn _instance = _StringsAddGoalPageEn._();

	String get title => 'Add Goal';
	String get input_name => 'Name';
	String get input_description => 'Description';
	String get input_select_date => 'Select Date';
	String get select_date_no_date_selected => 'No date picked';
	String get button_add_goal => 'Add Goal';
	String get error_name_empty => 'Name cannot be empty';
	String get error_description_empty => 'Description cannot be empty';
	String get error_date_empty => 'Date cannot be empty';
	String get error_not_logged_in => 'You have to login first';
	String get error_general => 'An error occurred';
}

class _StringsGoalViewPageEn {
	_StringsGoalViewPageEn._(); // no constructor

	static final _StringsGoalViewPageEn _instance = _StringsGoalViewPageEn._();

	String get loading => 'Loading...';
	String get add_task => 'Add task';
	String get failed_deleting => 'Failed to delete. Please try again.';
	String get no_tasks_found => 'No tasks found.';
}

class _StringsDe implements _StringsEn {
	_StringsDe._(); // no constructor

	static final _StringsDe _instance = _StringsDe._();

	@override String get appName => 'Lernfortschritt Tracker';
	@override String get appNameShort => 'Lern Tracker';
	@override String get dateformat => 'dd.MM.yyyy';
	@override _StringsLoginPageDe get login_page => _StringsLoginPageDe._instance;
	@override _StringsHomePageDe get home_page => _StringsHomePageDe._instance;
	@override _StringsAddGoalPageDe get add_goal_page => _StringsAddGoalPageDe._instance;
	@override _StringsGoalViewPageDe get goal_view_page => _StringsGoalViewPageDe._instance;

	/// A flat map containing all translations.
	@override dynamic operator[](String key) => _translationMapDe[key];
}

class _StringsLoginPageDe implements _StringsLoginPageEn {
	_StringsLoginPageDe._(); // no constructor

	static final _StringsLoginPageDe _instance = _StringsLoginPageDe._();

	@override String get google_button => 'Mit Google Anmelden';
	@override String get anonymous_button => 'Ohne Account fortfahren';
	@override String get error => 'Fehler beim Anmelden';
}

class _StringsHomePageDe implements _StringsHomePageEn {
	_StringsHomePageDe._(); // no constructor

	static final _StringsHomePageDe _instance = _StringsHomePageDe._();

	@override String get fab => 'Ziel hinzufügen';
	@override String get no_goals => 'Keine Ziele.';
	@override String get error_loading_goals => 'Ziele konnten nicht geladen werden.';
}

class _StringsAddGoalPageDe implements _StringsAddGoalPageEn {
	_StringsAddGoalPageDe._(); // no constructor

	static final _StringsAddGoalPageDe _instance = _StringsAddGoalPageDe._();

	@override String get title => 'Ziel hinzufügen';
	@override String get input_name => 'Name';
	@override String get input_description => 'Beschreibung';
	@override String get input_select_date => 'Datum auswählen';
	@override String get select_date_no_date_selected => 'Kein Datum ausgewählt';
	@override String get button_add_goal => 'Ziel hinzufügen';
	@override String get error_name_empty => 'Der Name darf nicht leer sein';
	@override String get error_description_empty => 'Die Beschreibung darf nicht leer sein.';
	@override String get error_date_empty => 'Ein Datum muss ausgewählt werden.';
	@override String get error_not_logged_in => 'Du musst dich zuerst anmelden.';
	@override String get error_general => 'Ein Fehler ist aufgetreten.';
}

class _StringsGoalViewPageDe implements _StringsGoalViewPageEn {
	_StringsGoalViewPageDe._(); // no constructor

	static final _StringsGoalViewPageDe _instance = _StringsGoalViewPageDe._();

	@override String get loading => 'Laden...';
	@override String get add_task => 'Aufgabe hinzufügen';
	@override String get failed_deleting => 'Löschen ist fehlgeschlagen.';
	@override String get no_tasks_found => 'Keine Aufgaben gefunden.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

late final Map<String, dynamic> _translationMapEn = {
	'appName': 'Study Progress Tracker',
	'appNameShort': 'Study Tracker',
	'dateformat': 'MM/dd/yyyy',
	'login_page.google_button': 'Sign in with Google',
	'login_page.anonymous_button': 'Continue without account',
	'login_page.error': 'Could not log in',
	'home_page.fab': 'Add Goal',
	'home_page.no_goals': 'No Goal.',
	'home_page.error_loading_goals': 'An error occurred while loading your goals.',
	'add_goal_page.title': 'Add Goal',
	'add_goal_page.input_name': 'Name',
	'add_goal_page.input_description': 'Description',
	'add_goal_page.input_select_date': 'Select Date',
	'add_goal_page.select_date_no_date_selected': 'No date picked',
	'add_goal_page.button_add_goal': 'Add Goal',
	'add_goal_page.error_name_empty': 'Name cannot be empty',
	'add_goal_page.error_description_empty': 'Description cannot be empty',
	'add_goal_page.error_date_empty': 'Date cannot be empty',
	'add_goal_page.error_not_logged_in': 'You have to login first',
	'add_goal_page.error_general': 'An error occurred',
	'goal_view_page.loading': 'Loading...',
	'goal_view_page.add_task': 'Add task',
	'goal_view_page.failed_deleting': 'Failed to delete. Please try again.',
	'goal_view_page.no_tasks_found': 'No tasks found.',
};

late final Map<String, dynamic> _translationMapDe = {
	'appName': 'Lernfortschritt Tracker',
	'appNameShort': 'Lern Tracker',
	'dateformat': 'dd.MM.yyyy',
	'login_page.google_button': 'Mit Google Anmelden',
	'login_page.anonymous_button': 'Ohne Account fortfahren',
	'login_page.error': 'Fehler beim Anmelden',
	'home_page.fab': 'Ziel hinzufügen',
	'home_page.no_goals': 'Keine Ziele.',
	'home_page.error_loading_goals': 'Ziele konnten nicht geladen werden.',
	'add_goal_page.title': 'Ziel hinzufügen',
	'add_goal_page.input_name': 'Name',
	'add_goal_page.input_description': 'Beschreibung',
	'add_goal_page.input_select_date': 'Datum auswählen',
	'add_goal_page.select_date_no_date_selected': 'Kein Datum ausgewählt',
	'add_goal_page.button_add_goal': 'Ziel hinzufügen',
	'add_goal_page.error_name_empty': 'Der Name darf nicht leer sein',
	'add_goal_page.error_description_empty': 'Die Beschreibung darf nicht leer sein.',
	'add_goal_page.error_date_empty': 'Ein Datum muss ausgewählt werden.',
	'add_goal_page.error_not_logged_in': 'Du musst dich zuerst anmelden.',
	'add_goal_page.error_general': 'Ein Fehler ist aufgetreten.',
	'goal_view_page.loading': 'Laden...',
	'goal_view_page.add_task': 'Aufgabe hinzufügen',
	'goal_view_page.failed_deleting': 'Löschen ist fehlgeschlagen.',
	'goal_view_page.no_tasks_found': 'Keine Aufgaben gefunden.',
};
