import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vk/domain/factories/screen_factory.dart';
import 'package:vk/ui/design/colors.dart';
import 'package:vk/ui/design/images.dart';
import 'package:vk/ui/design/style.dart';



class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {

  // final movieListModel = MovieListModel();
  int _currentTabIndex = 1;
  final _screenFactory = ScreenFactory();

  void onSelectTab(int index) {
    if (_currentTabIndex == index) return; // не будем обновлять state, если вкладка уже выбрана
    setState(() {
    _currentTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   MovieListModel.setupLocale(context);
  // }


  static final List<Widget> _titleOptions = <Widget> [
    Text('Новости', style: StyleApp.titleStyle),
    Text('Фильмы', style: StyleApp.titleStyle,),
    Text('Сериалы', style: StyleApp.titleStyle,),
  ];

  @override
  Widget build(BuildContext context) {
    // final _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: _titleOptions[_currentTabIndex],
        actions: [
          Padding(
          padding:  EdgeInsets.only(right: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: () => {
                  // _authService.logout()
                },
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
            _screenFactory.makeNewsList(),
            _screenFactory.makeMovieList(),
            _screenFactory.makeTVShowListWidget(),
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


class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('1');
  }
}

class TVShowListWidget extends StatelessWidget {
  const TVShowListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('3');
  }
}