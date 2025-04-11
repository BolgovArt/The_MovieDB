import 'package:flutter/material.dart';
import 'package:vk/l10n/generated/app_localizations.dart';
import 'package:vk/ui/design/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vk/ui/navigation/main_navigation_route_names.dart';

abstract class MyAppNavigation {
  Map<String, Widget Function(BuildContext)> get routes;
  Route<Object> onGenerateRoute(RouteSettings settings);
}

class MyApp extends StatelessWidget {
  final MyAppNavigation navigation;
  const MyApp({super.key, required this.navigation,});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
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
      routes: navigation.routes,
      initialRoute: MainNavigationRouteNames.loaderWidget,
      onGenerateRoute: navigation.onGenerateRoute,
    );
  }
}

// Изменения: MainNavigation приходит извне, внутри этого файла не создается экземпляр класса MainNavigation.