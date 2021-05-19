import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';

class ListItem extends StatelessWidget {
  ListItem({
    this.contentPadding,
    this.onLongPress,
    this.trailing,
    this.subtitle,
    this.leading,
    this.title,
    this.onTap,
  });

  // contentPadding
  final EdgeInsetsGeometry contentPadding;

  // onLongPress
  final VoidCallback onLongPress;

  // onTap
  final VoidCallback onTap;

  // Reduce density for responsive ListTile
  final density = -4.0;

  /// Icon of item
  final Widget leading;

  /// Icon of item
  final Widget trailing;

  /// Title of item
  final Widget title;

  /// SubTitle of item
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // VisualDensity
      visualDensity: VisualDensity(
        horizontal: density,
        vertical: density,
      ),
      // Padding
      contentPadding: contentPadding,
      // onLongPress
      onLongPress: onLongPress,
      // SubTitle
      subtitle: subtitle,
      // Trailing
      trailing: trailing,
      // Leading
      leading: leading,
      // Title
      title: title,
      // onTap
      onTap: onTap,
      // density
      dense: true,
    );
  }
}

class ToggleFloatingActionsButtons extends StatefulWidget {
  final Widget icon;
  final Widget reverseIcon;
  final List<Widget> children;

  final double radius;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Animatable> animatables;

  ToggleFloatingActionsButtons({
    this.backgroundColor,
    this.foregroundColor,
    this.animatables,
    this.icon,
    this.radius,
    this.children,
    this.reverseIcon,
  });

  @override
  _ToggleFloatingActionsButtonsState createState() =>
      _ToggleFloatingActionsButtonsState();
}

class _ToggleFloatingActionsButtonsState
    extends State<ToggleFloatingActionsButtons> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Widget child;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    )..addListener(() => setState(() {}));

    animation = ReverseAnimation(controller);
    widget.animatables.forEach((animatable) {
      animation = animation.drive(animatable);
    });
    child = widget.icon;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void animate() {
    switch (controller.status) {
      case AnimationStatus.completed:
        child = widget.icon;
        controller.reverse();
        break;
      default:
        child = widget.reverseIcon;
        controller.forward();
    }
  }

  Widget button(Widget child, Size size, int position) {
    return Transform(
      transform: Matrix4.translationValues(
        0.0,
        animation.value * position * size.height * 1.12,
        0.0,
      ),
      child: SizedBox.fromSize(
        child: child,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size radius = Size.fromRadius(widget.radius);
    var itemCount = widget.children.length;
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = itemCount - 1; i >= 0; --i)
            button(
              widget.children.elementAt(i),
              radius,
              i + 1,
            ),
          button(
            FloatingActionButton(
              foregroundColor: widget.foregroundColor,
              backgroundColor: widget.backgroundColor,
              onPressed: animate,
              heroTag: 'toggle',
              child: child,
            ),
            radius * 1.1,
            0,
          ),
        ],
      ),
      height: (itemCount + 1) * radius.height * 1.1,
    );
  }
}

class Shimmer extends StatefulWidget {
  Shimmer({
    @required this.child,
    @required Color baseColor,
    @required Color highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  }) : gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: [baseColor, baseColor, highlightColor, baseColor, baseColor],
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        );

  final Widget child;
  final Duration duration;
  final Gradient gradient;

  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _Shimmer(
        child: widget.child,
        gradient: widget.gradient,
        percent: _controller.value,
      );
}

class _Shimmer extends SingleChildRenderObjectWidget {
  _Shimmer({Widget child, this.gradient, this.percent}) : super(child: child);

  final Gradient gradient;
  final double percent;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _ShimmerFilter(gradient);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _ShimmerFilter).shiftPercentage = percent;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  _ShimmerFilter(this._gradient);

  final Gradient _gradient;
  double _shiftPercentage = 0.0;

  set shiftPercentage(double newValue) {
    if (_shiftPercentage != newValue) {
      _shiftPercentage = newValue;
      markNeedsPaint();
    }
  }

  @override
  ShaderMaskLayer get layer => super.layer;

  @override
  bool get alwaysNeedsCompositing => child != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final width = child.size.width;
      final height = child.size.height;
      double dx =
          _offset(start: -width, end: width * 2, percent: _shiftPercentage);
      double dy = 0.0;
      final rect = Rect.fromLTWH(dx, dy, width, height);

      layer ??= ShaderMaskLayer();
      layer
        ..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer, super.paint, offset);
    }
  }

  double _offset({double start, double end, double percent}) =>
      start + (end - start) * percent;
}

class VideoPlayerProgressIndicator extends StatefulWidget {
  /// Construct an instance that displays the play/buffering status of the video
  /// controlled by [controller].
  ///
  /// Defaults will be used for everything except [controller] if they're not
  /// provided. [allowScrubbing] defaults to false, and [padding] will default
  /// to `top: 5.0`.
  VideoPlayerProgressIndicator(
    this.controller, {
    this.colors = const VideoProgressColors(),
    @required this.allowScrubbing,
    this.padding = const EdgeInsets.only(top: 5.0),
  });

  /// The [VideoPlayerController] that actually associates a video with this
  /// widget.
  final VideoPlayerController controller;

  /// The default colors used throughout the indicator.
  ///
  /// See [VideoProgressColors] for default values.
  final VideoProgressColors colors;

  /// When true, the widget will detect touch input and try to seek the video
  /// accordingly. The widget ignores such input when false.
  ///
  /// Defaults to false.
  final bool allowScrubbing;

  /// This allows for visual padding around the progress indicator that can
  /// still detect gestures via [allowScrubbing].
  ///
  /// Defaults to `top: 5.0`.
  final EdgeInsets padding;

  @override
  _VideoPlayerProgressIndicatorState createState() =>
      _VideoPlayerProgressIndicatorState();
}

class _VideoPlayerProgressIndicatorState
    extends State<VideoPlayerProgressIndicator> {
  _VideoPlayerProgressIndicatorState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  VideoProgressColors get colors => widget.colors;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;
    if (controller.value.isInitialized) {
      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;

      int maxBuffering = 0;
      for (DurationRange range in controller.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      progressIndicator = Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: LinearProgressIndicator(
                value: maxBuffering / duration,
                valueColor: AlwaysStoppedAnimation<Color>(colors.bufferedColor),
                backgroundColor: colors.backgroundColor,
              ),
            ),
          ),
          CupertinoSlider(
            onChanged: null,
            value: position / duration,
            thumbColor: colors.playedColor,
            activeColor: colors.playedColor,
          ),
        ],
      );
    } else {
      progressIndicator = LinearProgressIndicator(
        value: null,
        valueColor: AlwaysStoppedAnimation<Color>(colors.playedColor),
        backgroundColor: colors.backgroundColor,
      );
    }
    final Widget paddedProgressIndicator = Padding(
      padding: widget.padding,
      child: progressIndicator,
    );
    if (widget.allowScrubbing) {
      return _VideoScrubber(
        child: paddedProgressIndicator,
        controller: controller,
      );
    } else {
      return paddedProgressIndicator;
    }
  }
}

class _VideoScrubber extends StatefulWidget {
  _VideoScrubber({
    @required this.child,
    @required this.controller,
  });

  final Widget child;
  final VideoPlayerController controller;

  @override
  _VideoScrubberState createState() => _VideoScrubberState();
}

class _VideoScrubberState extends State<_VideoScrubber> {
  bool _controllerWasPlaying = false;

  VideoPlayerController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    void seekToRelativePosition(Offset globalPosition) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset tapPos = box.globalToLocal(globalPosition);
      final double relative = tapPos.dx / box.size.width;
      final Duration position = controller.value.duration * relative;
      controller.seekTo(position);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.child,
      onHorizontalDragStart: (DragStartDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        _controllerWasPlaying = controller.value.isPlaying;
        if (_controllerWasPlaying) {
          controller.pause();
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_controllerWasPlaying) {
          controller.play();
        }
      },
      onTapDown: (TapDownDetails details) {
        if (!controller.value.isInitialized) {
          return;
        }
        seekToRelativePosition(details.globalPosition);
      },
    );
  }
}

class VisibilityTimer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Widget replacement;

  VisibilityTimer({
    this.child,
    this.duration,
    this.replacement = const SizedBox.shrink(),
  });

  @override
  _VisibilityTimerState createState() => _VisibilityTimerState();
}

class _VisibilityTimerState extends State<VisibilityTimer> {
  Timer timer;
  bool visible;

  void cancelTimer() => timer?.cancel();

  void visibilityTimeout() {
    if (widget.duration != null) {
      timer = Timer(widget.duration, () {
        setState(() {
          visible = false;
        });
      });
    }
  }

  @override
  void initState() {
    visible = true;
    super.initState();
    visibilityTimeout();
  }

  @override
  void didUpdateWidget(covariant VisibilityTimer old) {
    cancelTimer();
    visible = true;
    visibilityTimeout();
    super.didUpdateWidget(old);
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: widget.child,
      replacement: widget.replacement,
    );
  }
}

class PlayerProgressSlider extends StatelessWidget {
  final double duration;
  final double buffered;
  final double position;
  final Color bufferedColor;
  final Color positionColor;

  final ValueChanged<double> onChanged;

  PlayerProgressSlider({
    this.buffered,
    this.duration,
    this.position,
    this.onChanged,
    this.bufferedColor,
    this.positionColor,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: LinearProgressIndicator(
            minHeight: 2.0,
            backgroundColor: Colors.transparent,
            value: buffered / max(1.0, duration),
            valueColor: AlwaysStoppedAnimation(bufferedColor),
          ),
        ),
        CupertinoSlider(
          onChanged: onChanged,
          activeColor: positionColor,
          value: position / max(1.0, duration),
        ),
        Padding(
          child: Position(
            onTap: onChanged,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
        ),
      ],
    );
  }
}

class Position extends StatelessWidget {
  final ValueChanged<double> onTap;

  Position({this.onTap});

  @override
  Widget build(BuildContext context) {
    void seekToRelativePosition(Offset globalPosition) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset tapPos = box.globalToLocal(globalPosition);
      final double relative = (tapPos.dx) / (box.size.width);
      onTap(relative);
    }

    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTapDown: (details) {
          seekToRelativePosition(details.globalPosition);
        },
      );
    });
  }
}

class MovieTile extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  final VoidCallback onTap;

  MovieTile({
    this.onTap,
    this.image,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: GridTile(
              child: Material(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: FadeInImage.assetNetwork(
                  placeholder: "images/spices-shop.jpeg",
                  fit: BoxFit.cover,
                  image: image,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              title,
              softWrap: false,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Antonio',
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              subtitle,
              softWrap: false,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Antonio',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}


class ScrollInfinity extends StatefulWidget {
  final Widget child;

  final VoidCallback onScrollEnd;

  ScrollInfinity({
    @required this.onScrollEnd,
    @required this.child,
  }) : assert(onScrollEnd != null);

  @override
  _ScrollInfinityState createState() => _ScrollInfinityState();
}

class _ScrollInfinityState extends State<ScrollInfinity> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: widget.child,
      onNotification: (notification) {
        var metrics = notification.metrics;
        var middle = metrics.maxScrollExtent * 0.5;
        if (metrics.pixels > middle) {
          widget.onScrollEnd();
        }
        return true;
      },
    );
  }
}
