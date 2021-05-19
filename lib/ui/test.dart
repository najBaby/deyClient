import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'widgets.dart';

class TestScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Player(
        videoUrl: "https://nan.ci",
      ),
    );
  }
}

class Player extends StatefulWidget {
  final String videoUrl;
  final String referer;

  Player({this.videoUrl, this.referer});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Future<void> initialize;
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      widget.videoUrl,
      httpHeaders: {
        "Referer": widget.referer,
      },
    );
    initialize = controller.initialize();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    controller.dispose();
    super.dispose();
  }

  Future<void> get modeVideo async {
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: modeVideo,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SizedBox.shrink();
          default:
        }
        return FutureBuilder<Object>(
          future: initialize,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
            }
            var media = MediaQuery.of(context);
            return Tile(
              background: AspectRatio(
                child: VideoPlayer(controller),
                aspectRatio: media.size.aspectRatio,
              ),
              foreground: ControllerPlayer(controller),
            );
          },
        );
      },
    );
  }
}

class Tile extends StatelessWidget {
  final Widget foreground;
  final Widget background;
  Tile({
    this.foreground,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: background,
        ),
        Positioned.fill(
          child: foreground,
        ),
      ],
    );
  }
}

class ControllerHeader extends StatelessWidget {
  ControllerHeader();

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      leading: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(CupertinoIcons.arrow_left),
      ),
    );
  }
}

class ControllerFooter extends StatelessWidget {
  ControllerFooter(this.controller);

  final VideoPlayerController controller;

  String durationString(Duration duration) {
    var rawDuration = duration.toString();
    rawDuration = rawDuration.substring(0, 7);
    return rawDuration.padLeft(8, "0");
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, player, child) {
        var duration = player.duration;
        var position = player.position;

        var buf = 0;
        for (DurationRange range in player.buffered) {
          final int end = range.end.inMilliseconds;
          if (end > buf) {
            buf = end;
          }
        }
        var pos = position.inMilliseconds;
        var dur = duration.inMilliseconds;

        return StatefulBuilder(builder: (context, setState) {
          return GridTileBar(
            title: Row(
              children: [
                Text(durationString(position)),
                Expanded(
                  child: PlayerProgressSlider(
                    onChanged: (value) {
                      setState(() {
                        controller.seekTo(duration * value);
                      });
                    },
                    buffered: buf.toDouble(),
                    duration: dur.toDouble(),
                    position: pos.toDouble(),
                  ),
                ),
                Text(durationString(duration)),
              ],
            ),
          );
        });
      },
    );
  }
}

class ControllerPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  ControllerPlayer(this.controller);

  @override
  _ControllerPlayerState createState() => _ControllerPlayerState();
}

class _ControllerPlayerState extends State<ControllerPlayer> {
  Duration duration;
  final timeout = Duration(seconds: 5);

  VideoPlayerController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return VisibilityTimer(
      duration: duration,
      child: GridTile(
        header: ControllerHeader(),
        footer: ControllerFooter(controller),
        child: Tile(
          foreground: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: IconButton(
                  iconSize: 40.0,
                  icon: Icon(CupertinoIcons.gobackward_10),
                  onPressed: () async {
                    if (controller.value.isInitialized) {
                      await controller.seekTo(
                        controller.value.position + Duration(seconds: -10),
                      );
                      setState(() {
                        duration = controller.value.isPlaying ? timeout : null;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Visibility(
                  visible: controller.value.isPlaying,
                  replacement: TextButton(
                    onPressed: () {
                      if (controller.value.isInitialized)
                        setState(() {
                          controller.play();
                          duration = timeout;
                        });
                    },
                    child: Icon(
                      CupertinoIcons.play_circle,
                      size: 0.0,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (controller.value.isInitialized)
                        setState(() {
                          controller.pause();
                          duration = null;
                        });
                    },
                    child: Icon(
                      CupertinoIcons.pause_circle,
                      size: 70.0,
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  iconSize: 40.0,
                  icon: Icon(CupertinoIcons.goforward_10),
                  onPressed: () async {
                    if (controller.value.isInitialized) {
                      await controller.seekTo(
                        controller.value.position + Duration(seconds: 10),
                      );
                      setState(() {
                        duration = controller.value.isPlaying ? timeout : null;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          background: GestureDetector(
            onTap: () {
              setState(() {
                duration = Duration.zero;
              });
            },
          ),
        ),
      ),
      replacement: GestureDetector(
        onTap: () {
          setState(() {
            duration = controller.value.isPlaying ? timeout : null;
          });
        },
      ),
    );
  }
}
