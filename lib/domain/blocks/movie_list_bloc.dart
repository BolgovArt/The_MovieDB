import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:vk/configuration/configuration.dart';
import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/entity/movie.dart';
import 'package:vk/domain/entity/popular_movie_responce.dart';

// резюме в конце

abstract class MovieListEvent {}

class MovieListEventLoadNextPage extends MovieListEvent {
  final String  locale;
  MovieListEventLoadNextPage(this.locale);
}

class MovieListEventLoadReset extends MovieListEvent {
  // final String locale;
  // MovieListEventLoadReset(this.locale);
  
}
class MovieListEventLoadSearchMovie extends MovieListEvent {
  final String query;
  // final String  locale;

  MovieListEventLoadSearchMovie(
    this.query, 
    // this.locale
    );
}

class MovieListContainer {
  final List<Movie> movies;
  final int currentPage;
  final int totalPage;

  bool get isComplete => currentPage >= totalPage;

  const MovieListContainer.inital()   //
  : movies = const <Movie>[],         // пустой первоначальный стейт контейнера
    currentPage = 0,                  // (ещё один конструктор получается что ли)
    totalPage = 1;                    //

  MovieListContainer({
    required this.movies,
    required this.currentPage,
    required this.totalPage,
  });
  

  @override
  bool operator ==(Object other) =>
    identical(this, other) || 
    other is MovieListContainer && 
      runtimeType == other.runtimeType &&
      movies == other.movies &&
      currentPage == other.currentPage &&
      totalPage == other.totalPage;

  @override 
  int get hashCode => 
    movies.hashCode ^ currentPage.hashCode ^ totalPage.hashCode; // ! ??? вообще непонятна строчка, почему для пустого класса хешу давали 0?
  
  MovieListContainer copyWith({
    List<Movie>? movies,
    int? currentPage,
    int? totalPage,
  }) {
    return MovieListContainer(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
    );
  }
}


class MovieListState {
  final MovieListContainer popularMovieContainer;
  final MovieListContainer searchMovieContainer;
  List<Movie> get  movies => isSearchMode ? searchMovieContainer.movies : popularMovieContainer.movies; // тут 
                            // в стейте (выше 2 строчки) 2 контейнера, а в список
                            // фильмов (movie_list_cubit.dart) нужно получать всего 1, а они 
                            // в контейнерах (в них movies, currentPage, totalPage).  // -> [1]
  final String searchQuery;
  
  bool get isSearchMode => searchQuery.isNotEmpty;

  const MovieListState.inital()
  : popularMovieContainer = const MovieListContainer.inital(),
    searchMovieContainer = const MovieListContainer.inital(),
    searchQuery = "";                    //
  
  MovieListState({
    required this.popularMovieContainer,
    required this.searchMovieContainer,
    required this.searchQuery,
  });

  @override
  bool operator ==(Object other) => //? {} вместо => вызывало ошибку. Почему?
    identical(this, other) || 
    other is MovieListState && 
      runtimeType == other.runtimeType &&
      popularMovieContainer == other.popularMovieContainer &&
      searchMovieContainer == other.searchMovieContainer &&
      searchQuery == other.searchQuery;
  

  @override 
  int get hashCode => 
    popularMovieContainer.hashCode ^
    searchMovieContainer.hashCode ^
    searchQuery.hashCode;
  
  MovieListState copyWith({
    MovieListContainer? popularMovieContainer,
    MovieListContainer? searchMovieContainer,
    String? searchQuery,
  }) {
    return MovieListState(
      popularMovieContainer: 
          popularMovieContainer ?? this.popularMovieContainer, 
      searchMovieContainer: searchMovieContainer ?? this.searchMovieContainer, 
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}



class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final _movieApiClient = MovieApiClient();
  
  MovieListBloc(super.initialState) {
    on<MovieListEvent>((event, emit) async {
      if (event is MovieListEventLoadNextPage) {
        await onMovieListEventLoadNextPage(event, emit);
      } else if (event is MovieListEventLoadReset) {
        await onMovieListEventLoadReset(event, emit);
      } else if (event is MovieListEventLoadSearchMovie) {
        await onMovieListEventLoadSearchMovie(event, emit);
      }
    },
    transformer: sequential()
    );
  }


  Future<void> onMovieListEventLoadNextPage(MovieListEventLoadNextPage event, Emitter<MovieListState> emit) async {
    if(state.isSearchMode) {
      final container = await _loadNextPage(state.searchMovieContainer, (nextPage) async {
        final result = await _movieApiClient.searchFilms(
        nextPage, 
        event.locale, 
        state.searchQuery,
        Configuration.apiKey, 
        Configuration.unsplashUrl
      );
      return result;
      });

      if (container != null) {
        final newState = state.copyWith(searchMovieContainer: container);
        emit(newState);
      }
    } else {

      final container = await _loadNextPage(state.popularMovieContainer, (nextPage) async {
        final result = await _movieApiClient.popularFilms(
        nextPage, 
        event.locale, 
        Configuration.apiKey, 
        Configuration.unsplashUrl
      );
      return result;
      });

      if (container != null) {
        final newState = state.copyWith(popularMovieContainer: container);
        emit(newState);
      }
    }
  }

  Future<MovieListContainer?> _loadNextPage( // возвращает новый стейт, не эмитит его
    MovieListContainer container,
    Future<PopularMovieResponce> Function(int) loader,
  ) async { 
    if (container.isComplete) return null;
      final nextPage = container.currentPage + 1;
      final result = await loader(nextPage);

      final movies = List<Movie>.from(container.movies)..addAll(result.movies); //!
      // final movies = container.movies..addAll(result.movies); //!
      // movies.addAll(result.movies);
      final newContainer = container.copyWith(
        movies: movies, 
        currentPage: result.page,
        totalPage: result.totalPages,
      );
      return newContainer;
  }

  

  Future<void> onMovieListEventLoadReset(MovieListEventLoadReset event, Emitter<MovieListState> emit) async {
    emit(const MovieListState.inital());
    // add(MovieListEventLoadNextPage(event.locale)); // требует локаль, onMovieListEventLoadReset тоже должен брать локаль. Добавлено в класс MovieListEventLoadReset
  }

  Future<void> onMovieListEventLoadSearchMovie(MovieListEventLoadSearchMovie event, Emitter<MovieListState> emit) async {
    if (state.searchQuery == event.query) return;
    final newState = state.copyWith(
      searchQuery: event.query, 
      searchMovieContainer: const MovieListContainer.inital()
    );
    // add(MovieListEventLoadNextPage(event.locale));
    emit(newState);
  }  

}


/* Список фильмов состоял из нескольких вещей - экран. Часть его логики была размазана. MovieListViewModel является клеем для 
внешнего мира сервиса и тд. Из movie_servise.dart вытащили popularFilms и searchFilm. У нас архитектура следующая:
один блок за бизнес логику отвечает, другой за вью. Вью пока что нет, тут написан блок с бизнес логикой. Ещё тут пришлось
использовать пагинатор - универсальный класс, котрый мог делать пагинацию и грузить определенные запросы.
movie_list_bloc.dart умеет загружать следующие страницы, сделать резет и обновить все внутри и поискать фильм. 

MovieListEventLoadNextPage - загрузка следующей страницы с локалью
MovieListEventLoadReset - сброс
MovieListEventLoadSearchMovie - переключение стейта в режим "поиск"
Все эти методы сами по себе ниче не делают, они просто переключают свой режим и только MovieListEventLoadNextPage грузит
следующуйю страницу.

Дальше проектировался стейт, в нем два подучастка - состояние популярных фильмов (popularMovieContainer) 
и фильмов которые мы сейчас ищем (searchMovieContainer). Поэтому они сразу вынесены в отдельный класс, названный 
MovieListContainer, он внутри себя содержит список фильмов этого контейнера, текущую страницу этого контейнера и 
общее кол-во страниц (вычисляемый: currentPage >= totalPage значит мы достигли конца и больше ниче грузить не нужно).
Сюда (в MovieListContainer) также добавлен .inital() - initial state - просто пустой стейт, чтобы было удобно его создавать.

Переходим к MovieListState, он содержит два контейнера для популярных фильмов и для тех что ищем сейчас
также .inilat() - пустой контейнер.

После всего этого переходим непосредственно к блоку. MovieListBloc. Ему нужна была зависимость от MovieApiClient и три
эвента - MovieListEventLoadNextPage, MovieListEventLoadReset и MovieListEventLoadSearchMovie. Они вызываются в порядке
строго один за одним, чтобы не было несколько загрузок nextPage'ей, Reset'ов одновременно. 
Функций эвентов тоже три (классическая декомпозиция). 
Первая (пусть будет первой) onMovieListEventLoadReset по сути просто ставит .inital() - initial state - и все 
(строчка searchMovieContainer: const MovieListContainer.inital()). 
Вторая onMovieListEventLoadSearchMovie проверяет, что если searchQuery у нас такой
не используется, то мы резетаем searchContainer, потому что обычный контейнер должен остаться и устанавливаем в стейт
новый запрос (строчка searchQuery: event.query) и эмитим новый стейт потом.
Третья onMovieListEventLoadNextPage уже более сложная. Сложная она потому, что мы можем загружать новую страницу как для
поиска, так и для популярных фильмов. Поэтому пришлось написать два похожих кода (в if-else) для final container. Далее 
в зависимости от того или иного контейнера (if-else). Если container.isComplete - страницы закончились, там делать нечего, 
делает return. Если же нет - получаем nextPage, делаем загрузку (loader), получаеам список фильмов. Из контейнера достаем 
список фильмов и добавляем туда фильмы, которые загрузились из лоадера (строчка movies.addAll(result.movies)). Создаем
новый контейнер, передав туда из результата текущую страницу и кол-во всех страниц, фильмов и возвращаем этот контейнер.
Изначально этот код был одинаков и для isSearchMode и для обычного мода, отличался только сам контейнер и метод загрузки, 
поэтому и был создан _loadNextPage, который как раз и содержит у себя в аргументах функцию loader, вызвав которую мы
загрузим фильмы (пока хз как причем). Также _loadNextPage содержит контейнер, с которого мы будем эту информацию (для load наверно)
получать. Функция _loadNextPage уже вызывается в onMovieListEventLoadNextPage. Если это isSearchMode, то мы делаем
_loadNextPage передавая туда searchMovieContainer (строчка state.searchMovieContainer). Ещё делаем функцию загрузки
(nextPage) async {... передавая туда nextPage который пришел, локализацию и тд. Возвращается результат (строчка return result;),
который уже будет пойман внутри _loadNextPage (в строчке final result = await loader(nextPage)), обработан и вернется
контейнер, который вернется обратно в onMovieListEventNextPage в final container = await _loadNextPage (. случая isSearchMode.
Контейнер может быть null, если ничего не пришлось загружать. Поэтому делаем проверку. Если не null, то копируем стейт
с searchMovieContainer с новым контейнером и эмичим новый стейт. Тоже самое делается для другого условия (if-else) когда 
страницы не закончились - isComplete false (в onMovieListEventLoadNextPage), единственная разница - другой контейнер,
другой запрос и с другим контейнером копируется стейт (строчка final newState = state.copyWith(popularMovieContainer: container)). 

Далее нужно делать ViewBloc отвечающий уже не за логику, а за вью.
*/