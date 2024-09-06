
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vk/domain/api_client/api_client.dart';
import 'package:vk/domain/entity/movie_details.dart';
import 'package:vk/domain/entity/movie_details_credits.dart';
import 'package:vk/library/widgets/inherited/provider.dart';
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
          _SummeryWidget(),
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
    final model = NotifierProvider.watch<MoviePageModel>(context);
    
    return Text(
      model?.movieDetails?.overview ?? '',
      style: TextStyle(
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
    final model = NotifierProvider.watch<MoviePageModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null 
          ? Image.network(ApiClient.imageUrl(backdropPath)) 
          : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            child: posterPath != null 
              ? Image.network(ApiClient.imageUrl(posterPath), scale: 4,) 
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
    final model = NotifierProvider.watch<MoviePageModel>(context);
    var year = model?.movieDetails?.releaseDate?.year.toString();
    year != null ? year = ' ($year)' : '';
    return Center(
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: model?.movieDetails?.title ?? '',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                )
            ),
            TextSpan(
              text: year,
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
    final model = NotifierProvider.watch<MoviePageModel>(context);
    // var voteAverage = model?.movieDetails?.voteAverage ?? 0;
    // voteAverage = voteAverage * 10;
    // voteAverage.toStringAsFixed(0);
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
              //     precent: voteAverage / 100,
              //     fillColor: Color.fromARGB(255, 10, 23, 25),
              //     lineColor: Color.fromARGB(255, 37, 203, 103),
              //     freeColor: Color.fromARGB(255, 25, 54, 31),
              //     lineWidth: 3,
              //     child: const Text(voteAverage.toStringAsFixed(0)),
              //   ),
              // ),
              SizedBox(width: 10),
              Text('Score'),
            ],
          )
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        TextButton(
          onPressed: () {}, 
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

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MoviePageModel>(context);
    if (model == null) return const SizedBox.shrink();
    var texts = <String>[];
    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    };
    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add('(${productionCountries.first.iso})');
    }

    final runtime = model.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');
    
    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var element in genres) {
        genresNames.add(element.name);
      }
      texts.add(genresNames.join(', '));
    }
    return ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          texts.join(' '),
          maxLines: 3, 
          textAlign: TextAlign.center,
          style: TextStyle(
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
    return Text(
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
    
    final model = NotifierProvider.watch<MoviePageModel>(context);
    var crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Column(
      children: crewChunks
        .map((chunk) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _PeopleWidgetsRow(employes: chunk),
        ))
        .toList()
    );
  }  
  }


class _PeopleWidgetsRow extends StatelessWidget {
  final List<Employee> employes;
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
  final Employee employee;
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