import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'service/schema/movie.pb.dart';
import 'widgets.dart';


class ControllerHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  ControllerHeader({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      leading: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(CupertinoIcons.arrow_left),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
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

class Player extends StatefulWidget {
  final Movie movie;
  Player({this.movie});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Duration duration;
  Future<void> initialize;
  Future<void> preference;
  VideoPlayerController controller;

  final timeout = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    log(widget.movie.video);
    controller = VideoPlayerController.network(
      widget.movie.video,
      httpHeaders: {
        "Referer": widget.movie.hoster,
      },
    );
    preference = setPreference;
    initialize = controller.initialize();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    controller.dispose();
    super.dispose();
  }

  Future<void> get setPreference async {
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget get controllerWidget => Tile(
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
                    if (controller.value.isInitialized) {
                      setState(() {
                        controller.play();
                        duration = timeout;
                      });
                    } else {
                      setState(() {
                        initialize = controller.initialize();
                      });
                    }
                  },
                  child: Icon(
                    CupertinoIcons.play_circle,
                    size: 70.0,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    if (controller.value.isInitialized) {
                      setState(() {
                        controller.pause();
                        duration = null;
                      });
                    } else {
                      initialize = controller.initialize();
                    }
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
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return FutureBuilder<void>(
      future: preference,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SizedBox.shrink();
          default:
        }
        return Tile(
          background: AspectRatio(
            child: VideoPlayer(controller),
            aspectRatio: media.size.aspectRatio,
          ),
          foreground: VisibilityTimer(
            duration: duration,
            child: GridTile(
              header: ControllerHeader(
                title: widget.movie.title,
                subtitle: widget.movie.subtitle,
              ),
              footer: ControllerFooter(controller),
              child: FutureBuilder<void>(
                future: initialize,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      );
                    default:
                  }
                  return controllerWidget;
                },
              ),
            ),
            replacement: GestureDetector(
              onTap: () {
                setState(() {
                  duration = controller.value.isPlaying ? timeout : null;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
