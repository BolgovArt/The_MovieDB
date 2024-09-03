import 'package:flutter/material.dart';
import 'package:vk/widgets/movie_details/film_page_main_info_widget.dart';
import 'package:vk/widgets/movie_details/film_page_main_screen_cast_widget.dart';


class MovieDetailsWidget extends StatefulWidget {
  final int movieId;
  const MovieDetailsWidget({super.key, required this.movieId});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
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
        title: const Text('Название фильма', style: TextStyle(color: Colors.white),),
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
