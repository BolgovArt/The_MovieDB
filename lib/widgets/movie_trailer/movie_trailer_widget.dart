// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerWidget extends StatefulWidget {
  final String youtubeKey;
  const MovieTrailerWidget({
    Key? key,
    required this.youtubeKey,
  }) : super(key: key);

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();


}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  late final YoutubePlayerController _controller;
    @override
  void initState() {
    super.initState();
    
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    
  }
  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      );
    return YoutubePlayerBuilder(
      player: player,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Трейлер'),
          ),
          body: Center(
            child: player,
          ),
        );
      }
    );
  }
}