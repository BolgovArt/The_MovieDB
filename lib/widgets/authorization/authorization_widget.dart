import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vk/design/colors.dart';
import 'package:vk/design/images.dart';
import 'package:vk/design/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vk/generated/locale_keys.g.dart';
import 'package:vk/widgets/authorization/authorization_model.dart';

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

    return Scaffold(
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
                  Text(LocaleKeys.app_title.tr(), style: StyleApp.titleStyle),
                ],
              ),
            ),
          ),
        ),
        body: Container(
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
                          text: LocaleKeys.registration.tr(),
                          buttonStyle: StyleApp.mainGreenButton
                          ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: LocaleKeys.registration_title.tr(),
                            style: StyleApp.mainTextGrey,
                            children: [
                              TextSpan(text: LocaleKeys.registration_title.tr(), style: StyleApp.mainTextGrey),
                              TextSpan(text: LocaleKeys.registration_title_2.tr(), style: StyleApp.mainTextGrey),
                              // ! Кнопка чуть выше основного текста - что делать?
                              WidgetSpan(
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,       // Убираем внутренние отступы
                                    minimumSize: Size(0, 0),        // Убираем минимальные размеры
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,  // Минимизируем область клика
                                  ),
                                  child: Text(LocaleKeys.registration_title_link.tr(), style: StyleApp.titleStyle,
                                  )
                                ),
                              ),
                              TextSpan(text: LocaleKeys.registration_title_3.tr())
                            ],
                          )
                                          ),
                      ),
                  
            ],
          ),
        ),
            ]
          )
        ),
        bottomNavigationBar: const _BottomLine());
  }
}




class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AuthModelProvider.read(context)?.model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(LocaleKeys.login.tr(), style: StyleApp.mainTextBlack),
          
        ]),
        const _ErrorMessageWidget(),
        TextField(
          controller: model?.logInTextController,
          decoration: 
            const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              isCollapsed: true,
              )
              ),
        

        // _ShowDeleteButtonLogin(logInTextController),
        const SizedBox(height: 10),
        Text(LocaleKeys.password.tr(), style: StyleApp.mainTextBlack),


        TextField(
          controller: model?.passwordTextController,
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
    final model = AuthModelProvider.watch(context)?.model;
    final onPressed = model?.canStartAuth == true ? () => model?.authorization(context) : null;
    final child = model?.isAuthProgress == true ? SizedBox(width: 15, height: 15, child: const CircularProgressIndicator()) : const Text('Login');
    return ElevatedButton(
      onPressed: onPressed,
      style: StyleApp.mainBlueButton,
      child: child,
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text(LocaleKeys.log_in.tr(), style: TextStyle(fontSize: 18)),
      //   ],
      //   )
        );
  }
}


// ! Все что ниже - старая форма, где есть корзинки и save enter. потом надо вернуться и допилить эти методы в модель
// class _FormWidget extends StatelessWidget {
//   const _FormWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Text(LocaleKeys.login.tr(), style: StyleApp.mainTextBlack),
//           if (errorText != null)
//             Text(errorText!,
//               style: const TextStyle(color: Colors.red, fontSize: 14)),
//         ]),
//         TextField(
//           controller: _logInTextController,
//           onChanged: (value) {
//             setState(() {
//               isFieldLoginEmpty = value.isEmpty;
//             });
//           },
//           decoration: 
//             InputDecoration(
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//               isCollapsed: true,
//               suffixIcon: 
//               isFieldLoginEmpty
//                 ? null
//               : IconButton(
                
//                 onPressed: _resetForm1,

//                 icon: Icon(Icons.delete),
//                 padding: EdgeInsets.zero,
//                 splashRadius: 24,
//                 color: Colors.grey,
//               )
//               )
//               ),
        

//         // _ShowDeleteButtonLogin(logInTextController),
//         const SizedBox(height: 10),
//         Text(LocaleKeys.password.tr(), style: StyleApp.mainTextBlack),


//         TextField(
//           controller: _passwordTextController,
//           onChanged: (value) {
//             setState(() {
//               isFieldPassEmpty = value.isEmpty;
//             });
//           },
//           decoration: 
//             InputDecoration(
//               border: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//               isCollapsed: true,
//               suffixIcon: isFieldPassEmpty ? null : IconButton(
//               onPressed: _resetForm2,
//               icon: Icon(Icons.delete),
//               padding: EdgeInsets.zero,
//               splashRadius: 24,
//               color: Colors.grey,
//             )),
//           obscureText: true
//           ),



//         Row(
//           children: [
//             Checkbox(
//                 value: isChecked,
//                 onChanged: (value) {isChecked=value!;
//                 setState(() {
                  
//                 });
//                 ;}
                  
//                 // (boolValue) {
//                 //   savedInputText(boolValue);
//                 // },
//                 // savedInputText
//                 ),
//             Text(LocaleKeys.save_enter.tr(), style: StyleApp.mainTextGrey),
//             const SizedBox(width: 5),
//             questionMark,
//           ],
//         ),
//         ElevatedButton(
//           onPressed: _authorization,
//           style: StyleApp.mainBlueButton,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(LocaleKeys.log_in.tr(), style: TextStyle(fontSize: 18)),
//             ],
//             ))
//       ],
//     );
//   }
// }



class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthModelProvider.watch(context)?.model.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Text(
      errorMessage!,
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
          Expanded(
              child: TextButton(
                  onPressed: () {
                    if (context.locale == Locale('ru')) {
                      context.setLocale(Locale('en'));
                    } else {
                      context.setLocale(Locale('ru'));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.language, color: systemTextBlueColor),
                      Text(LocaleKeys.language.tr(), style: StyleApp.mainSystemTextBlue),
                    ],
                  ))),
          const SizedBox(width: 16),
          Expanded(
              child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.theme.tr(), style: StyleApp.mainSystemTextBlue),
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
