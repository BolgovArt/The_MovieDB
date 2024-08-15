import 'package:flutter/material.dart';
import 'package:vk/design/colors.dart';

class StyleApp {
  static TextStyle titleStyle = const TextStyle(fontFamily: 'VK_sans', fontWeight: FontWeight.w500, color: Color.fromARGB(255, 17, 69, 133));
  static TextStyle mainTextGrey = const TextStyle(fontFamily: 'VK_sans', fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black38);
  static TextStyle mainTextGreyHintFon = const TextStyle(fontFamily: 'VK_sans', fontWeight: FontWeight.w400, fontSize: 18, color: Colors.black38);
  static TextStyle mainTextBlack = const TextStyle(fontFamily: 'VK_sans', fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black);
  static TextStyle mainSystemTextBlue = const TextStyle(fontFamily: 'VK_sans', fontWeight: FontWeight.w400, fontSize: 15, color: systemTextBlueColor);
  static ButtonStyle mainBlueButton = ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Color(0xFF0077FF)),
                                                    foregroundColor: const MaterialStatePropertyAll(Colors.white),
                                                    elevation: const MaterialStatePropertyAll(0),
                                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                                                    );
                                                
  static ButtonStyle mainGreenButton = ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 0, 24, 56)),
                                                    foregroundColor: const MaterialStatePropertyAll(Colors.white),
                                                    elevation: const MaterialStatePropertyAll(0),
                                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                                                    );

 
} 