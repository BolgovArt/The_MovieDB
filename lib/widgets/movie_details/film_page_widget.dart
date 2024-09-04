import 'package:flutter/material.dart';
import 'package:vk/library/widgets/inherited/provider.dart';
import 'package:vk/widgets/movie_details/film_page_main_info_widget.dart';
import 'package:vk/widgets/movie_details/film_page_main_screen_cast_widget.dart';
import 'package:vk/widgets/movie_details/film_page_model.dart';


class MoviePageWidget extends StatefulWidget {

  const MoviePageWidget({super.key,});

  @override
  State<MoviePageWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MoviePageWidget> {

// через didChangeDependencies в State мы все равно получаем нашу модель. Подписываемся на изменение локали. 
//Если она меняется, то и внутри модели она тоже автоматически будет меняться

// вместе с didChangeDependencies подтянутся и сами данные по фильму
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<MoviePageModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 187, 206),
      appBar: AppBar( 
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24, color: Colors.white),
        onPressed: () { Navigator.pop(context); },
        ),
  
        // titleSpacing: 2,
        title: _TitleWidget(),
        actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.favorite, color: Colors.white)),
        ],
      ),
      body: ColoredBox(
            color: const Color.fromRGBO(24, 23, 27, 1),
            child: ListView(
              children: const [
                MovieDetailsMainInfoWidget(),
                SizedBox(height: 30),
                FilmPageMainScreenCastWidget(),
              ],
            ),
            ),
    );
  }
}


// в данном файле меняется только название фильма, ради него не надо все перерисовывать, поэтому создаем отдельный виджет
// or при изменени модели менялся бы весь экран

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MoviePageModel>(context);
    return Text(model?.movieDetails?.title ?? 'Загрузка..', style: TextStyle(color: Colors.white),);
  }
}
