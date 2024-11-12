import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vk/ui/design/images.dart';
import 'package:vk/ui/design/style.dart';
import 'package:vk/ui/navigation/main_navigation.dart';
import 'package:vk/widgets/authorization/authorization_view_cubit.dart';


class _AuthDataStorage {
  String login = "";
  String password = "";
}

class AuthorizationWidget extends StatefulWidget {
  const AuthorizationWidget({super.key});

  @override
  State<AuthorizationWidget> createState() => _AuthorizationWidgetState();
}

class _AuthorizationWidgetState extends State<AuthorizationWidget> {
  final decoratedContainer = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(30));

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthViewCubit, AuthViewCubitState>(
      listener: _onAuthViewCubitStateChange,
      child: Provider(
        create: (_) => _AuthDataStorage(),
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: AppBar(
                clipBehavior: Clip.none,
                title: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      logoTheMVDB,
                      const SizedBox(height: 10),
                      Text('LocaleKeys.app_title.tr()', style: StyleApp.titleStyle),
                    ],
                  ),
                ),
              ),
            ),
            body: BodyWidget(decoratedContainer: decoratedContainer),
            bottomNavigationBar: const _BottomLine()
        ),
      ),
    );
  }
}

  void _onAuthViewCubitStateChange(BuildContext context, AuthViewCubitState state) {
    if (state is AuthViewCubitSuccessAuthState) {
      MainNavigation.resetNavigation(context);
  }
}




class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
    required this.decoratedContainer,
  });

  final BoxDecoration decoratedContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFedeef0),
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: decoratedContainer,
            child: const Column(
              children: [
                _FormWidget(),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Container(
              padding: const EdgeInsets.all(16),
              decoration: decoratedContainer,
              child: Column(
                children: [
                  _MainActionButtonRegistation(
                      text: 'LocaleKeys.registration.tr()',
                      buttonStyle: StyleApp.mainGreenButton
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'LocaleKeys.registration_title.tr()',
                        style: StyleApp.mainTextGrey,
                        children: [
                          TextSpan(text: 'LocaleKeys.registration_title.tr()', style: StyleApp.mainTextGrey),
                          TextSpan(text: 'LocaleKeys.registration_title_2.tr()', style: StyleApp.mainTextGrey),
                          WidgetSpan(
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,       // Убираем внутренние отступы
                                minimumSize: Size(0, 0),        // Убираем минимальные размеры
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,  // Минимизируем область клика
                              ),
                              child: Text('LocaleKeys.registration_title_link.tr()', style: StyleApp.titleStyle,
                              )
                            ),
                          ),
                          TextSpan(text: 'LocaleKeys.registration_title_3.tr()')
                        ],
                      )
                                      ),
                  ),
              
        ],
      ),
    ),
        ]
      )
    );
  }
}




class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('LocaleKeys.login.tr()', style: StyleApp.mainTextBlack),
          
        ]),
        const _ErrorMessageWidget(),
        TextField(
          onChanged: (text) => authDataStorage.login = text,
          decoration: 
            const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              isCollapsed: true,
              )
              ),
        

        const SizedBox(height: 10),
        Text('LocaleKeys.password.tr()', style: StyleApp.mainTextBlack),


        TextField(
          onChanged: (text) => authDataStorage.password = text,
          decoration: 
            const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              isCollapsed: true,
              ),
          obscureText: true
          ),


        const _AuthButtonWidget()
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthViewCubit>();
    final authDataStorage = context.read<_AuthDataStorage>();
    final canStartAuth = cubit.state is AuthViewCubitFormFillInProgressState 
    || cubit.state is AuthViewCubitErrorState;
    final onPressed = canStartAuth ? () => 
      cubit.authorization(login: authDataStorage.login, password: authDataStorage.password) 
      : null;
    final child = cubit.state is AuthViewCubitAuthInProgressState == true ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator()) : const Text('Login');
    return ElevatedButton(
      onPressed: onPressed,
      style: StyleApp.mainBlueButton,
      child: child,
        );
  }
}

 
class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final errorMessage = context.select((AuthViewCubit e))
    final errorMessage = context.select((AuthViewCubit c) {
      final state = c.state;
      return state is AuthViewCubitErrorState ? state.errorMessage : null;
    });
    if (errorMessage == null) return const SizedBox.shrink();
    return Text(
      errorMessage,
      style: const TextStyle(
        color: Colors.red, 
        fontSize: 14
        )
      );
  }
}

class _BottomLine extends StatelessWidget {
  const _BottomLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(width: 16),
          const SizedBox(width: 16),
          Expanded(
              child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('LocaleKeys.theme.tr()', style: StyleApp.mainSystemTextBlue),
                      const Icon(Icons.format_paint_outlined)
                    ],
                  ))),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}


class _MainActionButtonRegistation extends StatelessWidget {
  final String text;
  final ButtonStyle buttonStyle;
  void _registration() {}
  const _MainActionButtonRegistation(
      {super.key, required this.text, required this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: _registration,
        style: buttonStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(fontSize: 18)),
          ],
        ));
  }
}
