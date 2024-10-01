import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk/domain/api_client/image_downloader.dart';
import 'package:vk/domain/entity/movie_details_credits.dart';
import 'package:vk/ui/navigation/main_navigation.dart';
import 'package:vk/widgets/movie_details/film_page_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopPosterWidget(),
          Padding(
            padding: EdgeInsets.all(10),
            child: _MovieTextWidget(),
          ),
          _ScoreWidget(),
          _SummaryWidget(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: _OverViewWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: _DescriptionWidget(),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: _PeopleWidgets(),
          ),
        ],
    );
  }


}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final overview = context.select((MoviePageModel model) => model.data.overview);
    // final model = NotifierProvider.watch<MoviePageModel>(context);
    
    return Text(
      overview,
      style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final posterData = context.select((MoviePageModel model) => model.data.posterData);
    // final model = NotifierProvider.watch<MoviePageModel>(context);
    final backdropPath = posterData.backdropPath;
    final posterPath = posterData.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null 
          ? Image.network(ImageDownloader.imageUrl(backdropPath)) 
          : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            child: posterPath != null 
              ? Image.network(ImageDownloader.imageUrl(posterPath), scale: 4,) 
              : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}


class _MovieTextWidget extends StatelessWidget {
  const _MovieTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.watch<MoviePageModel>(context);
    final data = context.select((MoviePageModel model) => model.data.nameData);
    // var year = movieDetails?.releaseDate?.year.toString();
    // final title = movieDetails?.title;
    // var year = model?.movieDetails?.releaseDate?.year.toString();
    // year != null ? year = ' ($year)' : '';
    return Center(
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: data.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                )
            ),
            TextSpan(
              text: data.year,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ))
          ]
        )
      ),
    );
  }
}


class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final movieDetails = NotifierProvider.watch<MoviePageModel>(context)?.movieDetails;
    final scoreData = context.select((MoviePageModel model) => model.data.scoreData);
    final trailerKey = scoreData.trailerKey;
    // var voteAverage = movieDetails?.voteAverage ?? 0;
    // voteAverage = voteAverage * 10;
    // voteAverage.toStringAsFixed(0);
    // final videos = movieDetails?.videos.results.where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    // final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {}, 
          child: const Row(
            children: [
              Icon(Icons.rotate_left_outlined), // ! del
              // SizedBox(
              //   width: 40,
              //   height: 40,
              //   child: RadialPrecentWidget(
              //     precent: scoreData.voteAverage / 100,
              //     fillColor: Color.fromARGB(255, 10, 23, 25),
              //     lineColor: Color.fromARGB(255, 37, 203, 103),
              //     freeColor: Color.fromARGB(255, 25, 54, 31),
              //     lineWidth: 3,
              //     child: const Text(scoreData.voteAverage.toStringAsFixed(0)),
              //   ),
              // ),
              SizedBox(width: 10),
              Text('Score'),
            ],
          )
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        if (trailerKey != null)
          TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                MainNavigationRouteNames.movieTrailerWidget, 
                arguments: trailerKey
              ), 
              child: const Row(
                children: [
                  Icon(Icons.play_arrow),
                  Text('Play Trailer'),
                ],
              )
            )
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = context.read<MoviePageModel>();
    // final movieDetails = context.select((MoviePageModel model) => model.movieDetails);
    // final releaseDate = movieDetails?.releaseDate;

    // // final model = NotifierProvider.watch<MoviePageModel>(context);
    // if (model == null) return const SizedBox.shrink();
    // var texts = <String>[];
    // // final releaseDate = model.movieDetails?.releaseDate;
    // if (releaseDate != null) {
    //   texts.add(model.stringFromDate(releaseDate));
    // };
    // final productionCountries = movieDetails?.productionCountries;
    // if (productionCountries != null && productionCountries.isNotEmpty) {
    //   texts.add('(${productionCountries.first.iso})');
    // }

    // final runtime = movieDetails?.runtime ?? 0;
    // final duration = Duration(minutes: runtime);
    // final hours = duration.inHours;
    // final minutes = duration.inMinutes.remainder(60);
    // texts.add('${hours}h ${minutes}m');
    
    // final genres = movieDetails?.genres;
    // if (genres != null && genres.isNotEmpty) {
    //   var genresNames = <String>[];
    //   for (var element in genres) {
    //     genresNames.add(element.name);
    //   }
    //   texts.add(genresNames.join(', '));
    // }
    final summary = context.select((MoviePageModel model) => model.data.summary);
    return ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          summary,
          maxLines: 3, 
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}


class _OverViewWidget extends StatelessWidget {
  const _OverViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
            'Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          );
  }
}



class _PeopleWidgets extends StatelessWidget {
  const _PeopleWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    
    // final model = NotifierProvider.watch<MoviePageModel>(context);
    var peopleData = context.select((MoviePageModel model) => model.data.peopleData);
    // var crew = model?.movieDetails?.credits.crew;
    if (peopleData.isEmpty) return const SizedBox.shrink();
    // crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    // var crewChunks = <List<Employee>>[];
    // for (var i = 0; i < crew.length; i += 2) {
    //   crewChunks.add(
    //     crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
    //   );
    // }
    return Column(
      children: peopleData
        .map((chunk) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _PeopleWidgetsRow(employes: chunk),
        ))
        .toList()
    );
  }  
  }


class _PeopleWidgetsRow extends StatelessWidget {
  final List<MoviePageMoviePeopleData> employes;
  const _PeopleWidgetsRow({super.key, required this.employes});

  @override
  Widget build(BuildContext context) {
    
    return 
        Row(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: employes
            .map((employe) => _PeopleWidgetsRowItem(employee: employe))
            .toList(),
    );
  }
}


class _PeopleWidgetsRowItem extends StatelessWidget {
  final MoviePageMoviePeopleData employee;
  const _PeopleWidgetsRowItem({
    super.key,
    required this.employee,
    });

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    const roleStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    return Expanded(
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: nameStyle,
                    ),
                  Text(
                    
                    employee.job,
                    style: roleStyle,
                    ),
                ]
              ),
    );
  }
}