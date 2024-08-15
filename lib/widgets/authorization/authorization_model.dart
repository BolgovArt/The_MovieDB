import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {


// все что ниже - код из stf _FormWidget, когда он ещё был stf

// bool isChecked = true;

//   void _resetForm1() {

//     var login = _logInTextController.text;
//     if (login.isNotEmpty) {
//       _logInTextController.text = '';
//       isFieldLoginEmpty = true;
//     }
//     setState(() {
      
//     });
//   }


//     void _resetForm2() {
//     var password = _passwordTextController.text;
//     if (password.isNotEmpty) {
//       _passwordTextController.text = '';
//             isFieldPassEmpty = true;
//     }
//     setState(() {
      
//     });
//   }


  // final _logInTextController = TextEditingController(text: 'admin');
  // final _passwordTextController = TextEditingController(text: 'admin');
  
  

  // String? errorText = null;

//   void _authorization() {
//     final login = _logInTextController.text;
//     final password = _passwordTextController.text;

//     if (login == 'admin' && password == 'admin') {
//       Navigator.of(context).pushReplacementNamed('/main_screen');
//       errorText = null;
//     } else {
//       errorText = LocaleKeys.error_login_or_password.tr();
//     }

//     if (login.isEmpty && password.isEmpty) {
//       errorText = LocaleKeys.error_empty_fields.tr();
//     }

//     setState(() {});
//   }


//   bool isFieldLoginEmpty = false;
//   bool isFieldPassEmpty = false;






  final logInTextController = TextEditingController(text: 'admin');
  final passwordTextController = TextEditingController(text: 'admin');

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  

  String? errorMessage = null;

  Future<void> authorization(BuildContext context) async {
  //   final login = _logInTextController.text;
  //   final password = _passwordTextController.text;

  //   if (login == 'admin' && password == 'admin') {
  //     Navigator.of(context).pushReplacementNamed('/main_screen');
  //     errorText = null;
  //   } else {
  //     errorText = LocaleKeys.error_login_or_password.tr();
  //   }

  //   if (login.isEmpty && password.isEmpty) {
  //     errorText = LocaleKeys.error_empty_fields.tr();
  //   }

  //   setState(() {});
  // }


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

