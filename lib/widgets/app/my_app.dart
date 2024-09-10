import 'package:flutter/material.dart';
import 'package:vk/library/widgets/inherited/provider.dart';
import 'package:vk/ui/design/colors.dart';
import 'package:vk/ui/navigation/main_navigation.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:vk/widgets/app/my_app_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({super.key,});


  @override
  Widget build(BuildContext context) {
    final model = Provider.read(context);
    return MaterialApp(

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', ''),
      ],

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: systemTextBlueColor,
          unselectedItemColor: Colors.grey,
        )
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}