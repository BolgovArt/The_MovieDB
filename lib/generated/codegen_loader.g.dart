// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "app_title": "Login to your account",
  "registration": "Registration",
  "registration_title": "To use TMDB's editing and ranking features, and receive personalized recommendations, you must be logged in to your account. If you don't have an account, registering is free and easy.",
  "registration_title_2": " If you registered but did not receive a confirmation email",
  "registration_title_link": " click here ",
  "registration_title_3": "to resend the letter.",
  "login": "Login",
  "password": "Password",
  "save_enter": "Save login and password",
  "log_in": "Log in",
  "language": "English",
  "theme": "Theme",
  "error_login_or_password": "Incorrect login or password",
  "error_empty_fields": "Fields are empty"
};
static const Map<String,dynamic> ru = {
  "app_title": "Войдите в свою учетную запись",
  "registration": "Регистрация",
  "registration_title": "Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, необходимо войти в свою учётную запись. Если у вас нет учётной записи, её регистрация является бесплатной и простой.",
  "registration_title_2": " Если Вы зарегистрировались, но не получили письмо для подтверждения, ",
  "registration_title_link": "нажмите здесь",
  "registration_title_3": ", чтобы отправить письмо повторно.",
  "login": "Логин",
  "password": "Пароль",
  "save_enter": "Сохранить вход",
  "log_in": "Войти",
  "language": "Русский",
  "theme": "Тема",
  "error_login_or_password": "Неправильный логин или пароль",
  "error_empty_fields": "Поля пусты"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
