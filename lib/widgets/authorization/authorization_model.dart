import 'package:flutter/material.dart';
import 'package:vk/domain/api_client/api_client.dart';

class AuthModel extends ChangeNotifier {


  final _apiClient = ApiClient();


  // final logInTextController = TextEditingController(text: 'admin');
  // final passwordTextController = TextEditingController(text: 'admin');

  
  final logInTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;
  

  String? _errorMessage = null;
  String? get errorMessage => _errorMessage;

  Future<void> authorization(BuildContext context) async {

    final login = logInTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(username: login, password: password);
      // _isAuthProgress = false;
      // notifyListeners();
    } catch (e) {
      _errorMessage = 'Неправильный логин/пароль/нет инета/сервер крякнул/телефон сломался хз';
    }
    _isAuthProgress = false;
    if (_errorMessage != null || sessionId == null) {
    notifyListeners();
    }
    print('Все хорошо');
    // Navigator.of(context).pop();
}
}

class AuthModelProvider extends InheritedNotifier {
  final AuthModel model;

  const AuthModelProvider({
  Key? key,
  required this.model,
  required Widget child,
}) : super(
  key: key,
  notifier: model,
  child: child,
);

  static AuthModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthModelProvider>();
  }

  static AuthModelProvider? read(BuildContext context) {
    final widget = 
      context.getElementForInheritedWidgetOfExactType<AuthModelProvider>()?.widget;
    return widget is AuthModelProvider ? widget : null; // Эта строка кода в Dart проверяет, является ли объект widget экземпляром класса StartPageModelProvider. Если да, то возвращает widget, иначе возвращает null
  }

}

