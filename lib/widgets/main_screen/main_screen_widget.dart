import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vk/domain/services/auth_service.dart';
import 'package:vk/extentions/context_extention.dart';
import 'package:vk/ui/design/colors.dart';
import 'package:vk/ui/design/images.dart';
import 'package:vk/ui/design/style.dart';
import 'package:vk/ui/navigation/main_navigation.dart';
import 'package:vk/widgets/main_screen/main_screen_model.dart';



class MainScreenWidget extends StatefulWidget {
  final ScreenFactory screenFactory;

  const MainScreenWidget({super.key, required this.screenFactory});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {

  // final movieListModel = MovieListModel();
  int _currentTabIndex = 1;

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


  // static final List<Widget> _titleOptions = <Widget> [
  //   Text(context.loc.buttom_page_icon_one, style: StyleApp.titleStyle),
  //   Text('Фильмы', style: StyleApp.titleStyle,),
  //   Text('Сериалы', style: StyleApp.titleStyle,),
  // ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _titleOptions = <Widget> [
    Text(context.loc.buttom_page_icon_one, style: StyleApp.titleStyle),
    Text(context.loc.buttom_page_icon_two, style: StyleApp.titleStyle,),
    Text(context.loc.buttom_page_icon_three, style: StyleApp.titleStyle,),
  ];
    // final _authService = AuthService(authApiClient: null);
    final model = context.read<MainScreenModel>();
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
                  model.logout(context)
                },
                icon: Icon(Icons.logout_rounded)
                ),
              Text(context.loc.log_out_button),
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
            widget.screenFactory.makeNewsList(),
            widget.screenFactory.makeMovieList(),
            widget.screenFactory.makeTVShowListWidget(),
          ]
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: onSelectTab,
        items: [
          BottomNavigationBarItem(icon: bottomHomeIcon(Colors.grey), label: context.loc.buttom_page_icon_one, activeIcon: bottomHomeIcon(systemTextBlueColor)),
          BottomNavigationBarItem(icon: bottomChatIcon(Colors.grey), label: context.loc.buttom_page_icon_two, activeIcon: bottomChatIcon(systemTextBlueColor)),
          BottomNavigationBarItem(icon: bottomMusicIcon(Colors.grey), label: context.loc.buttom_page_icon_three, activeIcon: bottomMusicIcon(systemTextBlueColor)),
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