import 'dart:ui';
import 'dart:math';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  final Text title;
  final Text subtitle;

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
                child: SizedBox.expand(
                  child: Image(
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame, loaded) {
                      if (frame != null) {
                        return child;
                      }
                      return Container(color: Colors.grey[800]);
                    },
                    image: NetworkImage(image),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: title,
            subtitle: subtitle,
          ),
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
