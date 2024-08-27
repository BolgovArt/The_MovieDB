import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vk/ui/design/colors.dart';
import 'package:vk/ui/design/images.dart';
import 'package:vk/ui/design/style.dart';
import 'package:vk/widgets/main_screen/messages/messages_page.dart';



class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {


  

int _currentTabIndex = 0;
  void onSelectTab(int index) {
    if (_currentTabIndex == index) return; // не будем обновлять state, если вкладка уже выбрана
    setState(() {
    _currentTabIndex = index;
    });
  }

  // static const List<Widget> _widgetOptions = <Widget> [
  //   Text('1'),
  //   MessagePage(),
  //   Text('3'),
  // ];



  static final List<Widget> _titleOptions = <Widget> [
    // Row(
    //   children: [
    //     avatar,
    //     Text('Главная', style: StyleApp.titleStyle),
    //   ],
    // ),
    Text('Главная', style: StyleApp.titleStyle),
    Text('Чаты', style: StyleApp.titleStyle,),
    Text('Музыка', style: StyleApp.titleStyle,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleOptions[_currentTabIndex],
        actions: [Padding(
          padding: const EdgeInsets.only(right: 16),
          child: vkTextAndLogo
          )],
      ),
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          // Image.asset('assets/images/avatar.jpg', height: 12, width: 12),
          // Image.asset('assets/images/avatar.jpg', width: 150, height: 150),
          // Text('1'),
          MessagePage(),
          Text('3'),
        ]
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: onSelectTab,
        items: [
          BottomNavigationBarItem(icon: bottomHomeIcon(Colors.grey), label: 'Главная', activeIcon: bottomHomeIcon(systemTextBlueColor)),
          BottomNavigationBarItem(icon: bottomChatIcon(Colors.grey), label: 'Чаты', activeIcon: bottomChatIcon(systemTextBlueColor)),
          BottomNavigationBarItem(icon: bottomMusicIcon(Colors.grey), label: 'Музыка', activeIcon: bottomMusicIcon(systemTextBlueColor)),
        ]
      ),
    );
  }
}