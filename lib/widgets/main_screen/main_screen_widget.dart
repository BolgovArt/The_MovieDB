import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vk/domain/data_providers/session_data_provider.dart';
import 'package:vk/ui/design/colors.dart';
import 'package:vk/ui/design/images.dart';
import 'package:vk/ui/design/style.dart';
import 'package:vk/widgets/main_screen/messages/movies_page.dart';



class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {


int _currentTabIndex = 1;
  void onSelectTab(int index) {
    if (_currentTabIndex == index) return; // не будем обновлять state, если вкладка уже выбрана
    setState(() {
    _currentTabIndex = index;
    });
  }


  static final List<Widget> _titleOptions = <Widget> [
    Text('Новости', style: StyleApp.titleStyle),
    Text('Фильмы', style: StyleApp.titleStyle,),
    Text('Сериалы', style: StyleApp.titleStyle,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleOptions[_currentTabIndex],
        actions: [
          Padding(
          padding:  EdgeInsets.only(right: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () => SessionDataProvider().setSessionId(null),
                icon: Icon(Icons.logout_rounded)
                ),
              Text('Выход из \nаккаунта'),
            ],
          )
          )
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: IndexedStack(
          index: _currentTabIndex,
          children: [
            Text('1'),
            FilmsPage(),
            Text('3'),
          ]
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: onSelectTab,
        items: [
          BottomNavigationBarItem(icon: bottomHomeIcon(Colors.grey), label: 'Новости', activeIcon: bottomHomeIcon(systemTextBlueColor)),
          BottomNavigationBarItem(icon: bottomChatIcon(Colors.grey), label: 'Фильмы', activeIcon: bottomChatIcon(systemTextBlueColor)),
          BottomNavigationBarItem(icon: bottomMusicIcon(Colors.grey), label: 'Сериалы', activeIcon: bottomMusicIcon(systemTextBlueColor)),
        ]
      ),
    );
  }
}