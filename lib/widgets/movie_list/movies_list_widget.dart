import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vk/domain/api_client/api_client.dart';
import 'package:vk/library/widgets/inherited/provider.dart';
import 'package:vk/ui/design/style.dart';
import 'package:vk/widgets/movie_list/movie_list_model.dart';


class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              separatorBuilder: (context, index) {return Container(height: 20,);},
              padding: const EdgeInsets.only(top: 45),
              itemCount: model.movies.length,
              itemBuilder: (BuildContext context, int index){
                final item = model.movies[index];
                final posterPath = item.posterPath;
                return 
                Material(
                  color: Colors.white,
                  child: InkWell(
                        onTap: () => model.onFilmTap(context, index),
                        child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                        children: [
                          posterPath != null ? Image.network(ApiClient.imageUrl(posterPath), width: 95,) : SizedBox.shrink(),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 20,),
                                Text(
                                  item.title, 
                                  maxLines: 2, 
                                  overflow: TextOverflow.ellipsis,
                                  // style: StyleApp.mainTextBlack,
                                  ),
                                // const SizedBox(height: 20,),
                                Text(
                                  model.stringFromDate(item.releaseDate),
                                  maxLines: 2, 
                                  overflow: TextOverflow.ellipsis,
                                  style: StyleApp.mainTextGrey
                                  ),
                                const SizedBox(height: 20,),
                                Text(
                                  item.overview, 
                                  maxLines: 2, 
                                  overflow: TextOverflow.ellipsis,
                                  // style: StyleApp.mainTextGrey, 
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),    
                          const Align(
                            alignment: Alignment.centerRight,
                            // child: Text(item.filmRate)
                            child: Text('4.5')
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