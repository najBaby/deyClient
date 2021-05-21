import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'widgets.dart';
import 'service/schema/movie.pb.dart';

class Player extends StatefulWidget {
  final Movie movie;
  Player({this.movie});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var aspectRatio = media.size.aspectRatio;

    return Tile(
      background: AspectRatio(
        aspectRatio: aspectRatio,
        child: VideoPlayer(controller),
      ),
      foreground: Container(),
    );
  }
}
