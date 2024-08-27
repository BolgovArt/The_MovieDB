import 'package:flutter/material.dart';
import 'package:vk/ui/design/colors.dart';
import 'package:vk/ui/navigation/main_navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vk/widgets/app/my_app_model.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({super.key, required this.model});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}