// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get authorization => 'Авторизация';

  @override
  String get login => 'Ваш логин:';

  @override
  String get password => 'Ваш пароль:';

  @override
  String get login_button => 'Войти';

  @override
  String get registration_button => 'Регистрация';

  @override
  String get registration_title_one => 'Если Вы зарегистрировались, но не получили письмо для подтверждения, ';

  @override
  String get registration_title_two => 'нажмите здесь ';

  @override
  String get registration_title_three => ', чтобы отправить письмо повторно.';

  @override
  String get change_theme => 'Сменить тему';

  @override
  String get attention_empty_fields => 'Заполните логин и пароль';

  @override
  String get auth_model_network_error => 'Сервер недоступен. Проверьте подключение к интернету.';

  @override
  String get auth_model_network_auth => 'Неправильный логин или пароль';

  @override
  String get auth_model_network_other => 'Произошла ошибка, попробуйте ещё раз.';

  @override
  String get auth_model_network_sessionExpired => 'Ошибка сессии';

  @override
  String get movies_page_title => 'Фильмы';

  @override
  String get log_out_button => 'Выход из \nаккаунта';

  @override
  String get search_panel => 'Поиск фильмов';

  @override
  String get buttom_page_icon_one => 'Новости';

  @override
  String get buttom_page_icon_two => 'Фильмы';

  @override
  String get buttom_page_icon_three => 'Сериалы';

  @override
  String get casts_list => 'Список актёров';
}
