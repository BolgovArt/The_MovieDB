import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk/domain/api_client/image_downloader.dart';
import 'package:vk/ui/design/style.dart';
import 'package:vk/ui/navigation/main_navigation.dart';
import 'package:vk/widgets/movie_list/movie_list_cubit.dart';
import 'package:vk/widgets/movie_list/movie_list_model.dart';


class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MovieListCubit>().setupLocale(locale.languageCode);
    // context.read<MovieListModel>().setupLocale(context);
    // Future.microtask(
    //   () => context.read<MovieListModel>().setupLocale(locale),
    // );
  }

  


  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _MovieListWidget(),
        _SearchWidget(),
      ],
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MovieListCubit>();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16,),
        child: TextField(
          onChanged: cubit.searchFilms,
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
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MovieListCubit>();
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          separatorBuilder: (context, index) {return Container(height: 20,);},
          padding: const EdgeInsets.only(top: 45),
          itemCount: cubit.state.movies.length,
          itemBuilder: (BuildContext context, int index){
            cubit.showFilmAtIndex(index);
            return _MovieListRowWidget(index: index,);
          },       
        );
  }
}


class _MovieListRowWidget extends StatelessWidget {

  final int index;

  const _MovieListRowWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MovieListCubit>();
    final item = cubit.state.movies[index];
            final posterPath = item.posterPath;
            return 
            Material(
              color: Colors.white,
              child: InkWell(
                    onTap: () => _onFilmTap(context, item.id),
                    child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                    children: [
                      Image.network(ImageDownloader.imageUrl(posterPath), width: 95,),
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
                              item.releaseDate,
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
  }

  void _onFilmTap(BuildContext context, int movieId) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: movieId
    );
  }
}