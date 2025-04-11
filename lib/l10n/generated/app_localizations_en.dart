// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authorization => 'Authorization';

  @override
  String get login => 'Your login:';

  @override
  String get password => 'Your password:';

  @override
  String get login_button => 'Login';

  @override
  String get registration_button => 'Registration';

  @override
  String get registration_title_one => 'If you have registered but have not received a confirmation email, ';

  @override
  String get registration_title_two => 'Click here ';

  @override
  String get registration_title_three => 'to resend the letter.';

  @override
  String get change_theme => 'Change theme';

  @override
  String get attention_empty_fields => 'Fill in your login and password';

  @override
  String get auth_model_network_error => 'The server is unavailable. Check your internet connection.';

  @override
  String get auth_model_network_auth => 'Incorrect login or password';

  @override
  String get auth_model_network_other => 'An error occurred, please try again.';

  @override
  String get auth_model_network_sessionExpired => 'Session error';

  @override
  String get movies_page_title => 'Movies';

  @override
  String get log_out_button => 'Logout from \naccount';

  @override
  String get search_panel => 'Search movie';

  @override
  String get buttom_page_icon_one => 'News';

  @override
  String get buttom_page_icon_two => 'Movies';

  @override
  String get buttom_page_icon_three => 'Series';

  @override
  String get casts_list => 'List of actors';
}
