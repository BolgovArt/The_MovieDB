import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vk/ui/design/style.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class FilmRow {
  final int id;
  final Image image;
  final String filmTitle;
  final String filmData;
  final String filmDescription;
  final String filmRate;

  const FilmRow ({
    required this.id,
    required this.image, 
    required this.filmTitle, 
    required this.filmData, 
    required this.filmDescription,
    required this.filmRate
    });
}

class FilmsPage extends StatefulWidget {
  const FilmsPage({super.key});

  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {


  final _filmsList = [
    FilmRow(
      id: 1,
      image: Image.asset('assets/images/mock.jpg', width: 120, height: 200), 
      filmTitle: 'filmTitle', 
      filmData: 'filmData',
      filmDescription: 'Some Text Some \nText Some Text \nSome Text Some \nText Some Text', 
      filmRate: 'filmRate'
      ),
    FilmRow(
      id: 2,
      image: Image.asset('assets/images/mock.jpg', width: 120, height: 200), 
      filmTitle: 'Иван Иванов', 
      filmData: 'Привет',
      filmDescription: 'Some Text Some \nText Some Text \nSome Text Some \nText Some Text',        
      filmRate: '21:07'
      ),
    FilmRow(
      id: 3,
      image: Image.asset('assets/images/mock.jpg', width: 120, height: 200), 
      filmTitle: 'filmTitle', 
      filmData: 'filmData',
      filmDescription: 'Some Text Some \nText Some Text \nSome Text Some \nText Some Text', 
      filmRate: 'filmRate'
      ),
    FilmRow(
      id: 4,
      image: Image.asset('assets/images/mock.jpg', width: 120, height: 200), 
      filmTitle: 'filmTitle', 
      filmData: 'filmData',
      filmDescription: 'Some Text Some \nText Some Text \nSome Text Some \nText Some Text', 
      filmRate: 'filmRate'
      ),
      FilmRow(
      id: 5,
      image: Image.asset('assets/images/mock.jpg', width: 120, height: 200), 
      filmTitle: 'filmTitle', 
      filmData: 'filmData',
      filmDescription: 'Some Text \nSome Text Some Text \nSome Text Some \nText Some Text', 
      filmRate: 'filmRate'
      ),
      FilmRow(
      id: 6,
      image: Image.asset('assets/images/mock.jpg', width: 120, height: 200), 
      filmTitle: 'filmTitle', 
      filmData: 'filmData',
      filmDescription: 'Some Text \nSome Text Some Text \nSome Text Some \nText Some Text', 
      filmRate: 'filmRate'
      ),
      FilmRow(
      id: 7,
      image: Image.asset('assets/images/mock.jpg', width: 120, height: 200), 
      filmTitle: 'Ivan kudr', 
      filmData: 'filmData',
      filmDescription: 'Some Text \nSome Text Some Text \nSome Text Some \nText Some Text', 
      filmRate: 'filmRate'
      ),
  ];


final _searchController = TextEditingController();

void _searchFilm() {
  final field = _searchController.text;
  if (field.isEmpty) {
    _filteredFilmsList = _filmsList;
  } else {
    _filteredFilmsList = _filmsList.where((FilmRow element) {
      return element.filmTitle.toLowerCase().contains(field.toLowerCase());
    }).toList();
    }
  setState((){});
}


@override
  void initState() {
    super.initState();
    _searchController.addListener(_searchFilm);
    _filteredFilmsList = _filmsList;
  }
  

var _filteredFilmsList = <FilmRow>[];

  void _onFilm(index) {
    final id = _filmsList[index].id;
    Navigator.of(context).pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        
        ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              separatorBuilder: (context, index) {return Container(height: 20,);},
              padding: const EdgeInsets.only(top: 45),
              itemCount: _filteredFilmsList.length,
              itemBuilder: (BuildContext context, int index){
                final item = _filteredFilmsList[index];
                return 
                Material(
                  color: Colors.white,
                  child: InkWell(
                        onTap: () => _onFilm(index),
                        child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                        children: [
                          item.image,
                          Padding(
                            padding:const EdgeInsets.only(left: 16),
                            child: Container(
                              height: 200-28,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.filmTitle, style: StyleApp.mainTextBlack,),
                                  Text(item.filmData, style: StyleApp.mainTextGrey),
                                  Container(height: 20,),
                                  Text(item.filmDescription, style: StyleApp.mainTextGrey)
                                ],
                              ),
                            ),
                          ),
                          
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(item.filmRate)
                              ),
                          ),
                          
                          
                        ],
                        
                      ),
                    ),
                    
                  ),
                );
              },
              
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,),
                child: TextField(
                  
                  controller: _searchController,
                  // style: TextStyle(fontSize: 1),
                  decoration: InputDecoration(
              
                    filled: true,
                    fillColor: Color.fromARGB(235, 220, 223, 226),
                    prefixIcon: Icon(Icons.search, size: 24,), // ? Как изменить размер иконки?????????? Пробовал в контейнер оборачивать
                    prefixIconColor: Colors.black38,
                    // prefixIconConstraints: BoxConstraints(maxWidth: 20),
                    hintText: 'Поиск',
                    hintStyle: StyleApp.mainTextGrey,
                    // isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
              
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        style: BorderStyle.none
                      ),
                      borderRadius:BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none
                      ),
                      borderRadius:BorderRadius.circular(10)
                    ),
                    ),
                ),
              ),
            ),
      ],
    );

  }
}