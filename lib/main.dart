
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:vk/generated/codegen_loader.g.dart';
import 'package:vk/widgets/app/my_app.dart';
import 'package:vk/widgets/app/my_app_model.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    final model = MyAppModel();
    await model.checkAuth();
  runApp(
    MyApp(model: model)
  //   EasyLocalization(
  //     supportedLocales: [Locale('en'), Locale('ru')],
  //     path: 'assets/translations', // <-- change the path of the translation files 
  //     fallbackLocale: Locale('en'),
  //     assetLoader: CodegenLoader(),
  //     child: MyApp(model: model)
  //   ),
  );
}
