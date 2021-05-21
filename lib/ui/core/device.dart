import 'package:flutter/widgets.dart';

enum DeviceSize {
  Large,
  Small,
  Medium,
}

class Tablet extends Device {
  Tablet(DeviceSize size, double insets) : super(size, insets);
}

class Desktop extends Device {
  Desktop(DeviceSize size, double insets) : super(size, insets);
}

class Handset extends Device {
  Handset(DeviceSize size, double insets) : super(size, insets);
}

abstract class Device {
  Device(this.size, this.insets);

  double insets;
  DeviceSize size;

  static Device of(BuildContext context) {
    var media = MediaQuery.of(context);
    var shortestSide = media.size.shortestSide;
    var orientation = media.orientation;
    var width = media.size.width;

    var large = DeviceSize.Large;
    var small = DeviceSize.Large;
    var medium = DeviceSize.Large;

    var insets = _insets(width);
    if (_smallHandset(width, orientation)) return Handset(small, insets);
    if (_mediumHandset(width, orientation)) return Handset(medium, insets);
    if (_largeHandset(width, orientation)) return Handset(large, insets);

    if (_smallTablet(width, orientation)) return Handset(small, insets);
    if (_largeTablet(width, orientation)) return Tablet(large, insets);

    if (_smallDesktop(shortestSide)) return Desktop(small, insets);
    if (_mediumDesktop(shortestSide)) return Desktop(medium, insets);
    if (_largeDesktop(shortestSide)) return Desktop(large, insets);
    return Handset(medium, insets);
  }

  static bool _isPortrait(Orientation orientation) =>
      orientation == Orientation.portrait;

  static bool _isLandscape(Orientation orientation) =>
      orientation == Orientation.landscape;

  static double _insets(double value) {
    if (600 > value) return 4;
    if (840 > value && 600 < value) return 8;
    return 12;
  }

  static bool _largeHandset(double width, Orientation orientation) =>
      (400 < width && 600 > width && _isPortrait(orientation)) ||
      (720 < width && 840 > width && _isLandscape(orientation));
  static bool _smallHandset(double width, Orientation orientation) =>
      (360 > width && _isPortrait(orientation)) ||
      (480 < width && 600 > width && _isLandscape(orientation));
  static bool _mediumHandset(double width, Orientation orientation) =>
      (360 < width && 400 > width && _isPortrait(orientation)) ||
      (600 < width && 720 > width && _isLandscape(orientation));

  static bool _largeTablet(double width, Orientation orientation) =>
      (720 < width && 840 > width && _isPortrait(orientation)) ||
      (1024 < width && 1440 > width && _isLandscape(orientation));
  static bool _smallTablet(double width, Orientation orientation) =>
      (600 < width && 720 > width && _isPortrait(orientation)) ||
      (960 < width && 1024 > width && _isLandscape(orientation));

  static bool _largeDesktop(double width) => (1280 < width);
  static bool _smallDesktop(double width) => (960 < width && 1024 > width);
  static bool _mediumDesktop(double width) => (1024 < width && 1280 > width);
}
