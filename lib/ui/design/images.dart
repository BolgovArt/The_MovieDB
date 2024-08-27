import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final Widget vkLogo = SvgPicture.asset('assets/images/VK_Compact_Logo_(2021-present).svg', semanticsLabel: 'VK');
final Widget vkTextAndLogo = SvgPicture.asset('assets/images/VK_Text_Logo.svg', semanticsLabel: 'VK', width: 24, height: 24,);
final Widget questionMark = SvgPicture.asset('assets/images/questionmark.svg', height: 15, color: const Color.fromRGBO(0, 0, 0, 0.38),);
Widget bottomHomeIcon(Color colorParam) { return SvgPicture.asset('assets/images/bottom_home.svg', color: colorParam);}
Widget bottomChatIcon(Color colorParam) { return SvgPicture.asset('assets/images/bottom_chat.svg', color: colorParam);}
Widget bottomMusicIcon(Color colorParam) { return SvgPicture.asset('assets/images/bottom_music.svg', color: colorParam);}
Widget addElementIcon(Color colorParam) { return SvgPicture.asset('assets/images/add_item_icon.svg', color: colorParam);}
Widget microIcon(Color colorParam) { return SvgPicture.asset('assets/images/micro_icon.svg', color: colorParam);}
Widget smileIcon(Color colorParam) { return SvgPicture.asset('assets/images/smile_for_text.svg', height: 24, color: colorParam);}

Widget pointsHorizontalMenu(Color colorParam) { return SvgPicture.asset('assets/images/points_horizontal_menu.svg', color: colorParam);}
Widget callIcon(Color colorParam) { return SvgPicture.asset('assets/images/call_icon.svg', color: colorParam);}
Widget imageIcon(Color colorParam) { return SvgPicture.asset('assets/images/image_icon.svg',  color: colorParam);}
Widget noCheckedSms(Color colorParam) { return SvgPicture.asset('assets/images/sms_no_checked.svg', color: colorParam);}
Widget pingZakrep(Color colorParam) { return SvgPicture.asset('assets/images/forvard_zakrep.svg', color: colorParam);}
Widget trashIcon(Color colorParam) { return SvgPicture.asset('assets/images/delete_icon.svg', color: colorParam);}


final Widget logoTheMVDB = SvgPicture.asset('assets/images/LogoTheMVDB.svg', width: 40, height: 55, color: Color.fromARGB(255, 4, 40, 85));


// final Widget avatar = Image.asset('assets/images/avatar.jpg', height: 12);

