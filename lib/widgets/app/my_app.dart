
import 'package:flutter/material.dart';
import 'package:vk/design/colors.dart';
import 'package:vk/widgets/authorization/authorization_model.dart';
import 'package:vk/widgets/authorization/authorization_widget.dart';
import 'package:vk/widgets/main_screen/main_screen_widget.dart';
import 'package:vk/widgets/main_screen/messages/dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // colorScheme: ColorScheme.dark(),
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: systemTextBlueColor,
          unselectedItemColor: Colors.grey,
        )
      ),
      // home: AuthorizationWidget(),

      routes: {
        '/authorization': (context) => AuthModelProvider(model: AuthModel(), child: const AuthorizationWidget()),
        '/main_screen': (context) => const MainScreenWidget(),
        '/main_screen/dialog': (context) {
          final arguments = ModalRoute.of(context)!.settings.arguments;
          if (arguments is int) {
          return DialogScreen(dialogId: arguments);
          } else {
            return DialogScreen(dialogId: 0);
          }
        },
      },
      initialRoute: '/authorization',
    );
  }
}