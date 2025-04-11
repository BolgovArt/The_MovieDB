import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @authorization.
  ///
  /// In en, this message translates to:
  /// **'Authorization'**
  String get authorization;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Your login:'**
  String get login;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Your password:'**
  String get password;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_button;

  /// No description provided for @registration_button.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration_button;

  /// No description provided for @registration_title_one.
  ///
  /// In en, this message translates to:
  /// **'If you have registered but have not received a confirmation email, '**
  String get registration_title_one;

  /// No description provided for @registration_title_two.
  ///
  /// In en, this message translates to:
  /// **'Click here '**
  String get registration_title_two;

  /// No description provided for @registration_title_three.
  ///
  /// In en, this message translates to:
  /// **'to resend the letter.'**
  String get registration_title_three;

  /// No description provided for @change_theme.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get change_theme;

  /// No description provided for @attention_empty_fields.
  ///
  /// In en, this message translates to:
  /// **'Fill in your login and password'**
  String get attention_empty_fields;

  /// No description provided for @auth_model_network_error.
  ///
  /// In en, this message translates to:
  /// **'The server is unavailable. Check your internet connection.'**
  String get auth_model_network_error;

  /// No description provided for @auth_model_network_auth.
  ///
  /// In en, this message translates to:
  /// **'Incorrect login or password'**
  String get auth_model_network_auth;

  /// No description provided for @auth_model_network_other.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again.'**
  String get auth_model_network_other;

  /// No description provided for @auth_model_network_sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session error'**
  String get auth_model_network_sessionExpired;

  /// No description provided for @movies_page_title.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies_page_title;

  /// No description provided for @log_out_button.
  ///
  /// In en, this message translates to:
  /// **'Logout from \naccount'**
  String get log_out_button;

  /// No description provided for @search_panel.
  ///
  /// In en, this message translates to:
  /// **'Search movie'**
  String get search_panel;

  /// No description provided for @buttom_page_icon_one.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get buttom_page_icon_one;

  /// No description provided for @buttom_page_icon_two.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get buttom_page_icon_two;

  /// No description provided for @buttom_page_icon_three.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get buttom_page_icon_three;

  /// No description provided for @casts_list.
  ///
  /// In en, this message translates to:
  /// **'List of actors'**
  String get casts_list;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
