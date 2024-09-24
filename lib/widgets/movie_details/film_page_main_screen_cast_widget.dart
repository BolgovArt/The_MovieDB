import 'package:flutter/material.dart';
import 'package:vk/domain/api_client/movie_api_client.dart';
import 'package:vk/domain/api_client/image_downloader.dart';
import 'package:vk/library/widgets/inherited/provider.dart';
import 'package:vk/widgets/movie_details/film_page_model.dart';


class FilmPageMainScreenCastWidget extends StatelessWidget {
  const FilmPageMainScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Список актёров',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
              ),
          ),
          const SizedBox(
            height: 250,
            child: Scrollbar(
              child: _ActorListWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () {},
              child: Text('data')
              ),
          ),
        ],
      ),
      );
  }
}

class _ActorListWidget extends StatelessWidget {
  const _ActorListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MoviePageModel>(context);
    var cast = model?.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      itemCount: 20,
      itemExtent: 120, 
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _ActorListItemWidget(actorIndex: index);
      },
    );
  }
}

class _ActorListItemWidget extends StatelessWidget {
  final int actorIndex;
  const _ActorListItemWidget({
    super.key,
    required this.actorIndex,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MoviePageModel>(context);
    final actor = model!.movieDetails!.credits.cast[actorIndex];
    final profilePath = actor.profilePath;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              profilePath != null 
              ? Image.network(ImageDownloader.imageUrl(profilePath),fit: BoxFit.cover, height: 140, width: 120,)
              : const SizedBox.shrink(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        actor.name,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      SizedBox(height: 7),
                      Text(
                        actor.character,
                        maxLines: 2,
                        ),
                    ],
                  ),
                  ),
              )                            
            ],
          ),
        ),
      ),
    );
  }
}