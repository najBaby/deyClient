import 'package:flutter/material.dart';

class DeviceAspectRatio {
  final MediaQueryData media;
  DeviceAspectRatio.of(BuildContext context) : media = MediaQuery.of(context) {
    size = media.size;
    area = size.longestSide + size.longestSide / 2;
    _longestArea = size.longestSide * (1 / area);
    _shortestArea = size.shortestSide * (1 / area);

    _toolbarHeight = _shortestArea * 125;

    _heading1 = _longestArea * 55;
    _heading2 = _longestArea * 50;
    _heading3 = _longestArea * 45;
    _heading4 = _longestArea * 40;
    _heading5 = _longestArea * 35;
    _heading6 = _longestArea * 30;

    _bodyText1 = _longestArea * 30;
    _bodyText2 = _longestArea * 20;

    _subtitle1 = _longestArea * 20;
    _subtitle2 = _shortestArea * 30;

    _button = _longestArea * 15;
    _caption = _longestArea * 15;
    _overline = _longestArea * 15;

    _icon1 = longestArea * 35;
    _icon2 = shortestArea * 50;
    _icon3 = longestArea * 15;
  }

  Size size;
  double area;
  double _longestArea;
  double _shortestArea;

  double _heading1;
  double _heading2;
  double _heading3;
  double _heading4;
  double _heading5;
  double _heading6;

  double _subtitle1;
  double _subtitle2;

  double _bodyText1;
  double _bodyText2;

  double _button;
  double _caption;
  double _overline;

  double _icon1;
  double _icon2;
  double _icon3;

  double _toolbarHeight;

  double get longestArea => _longestArea;
  double get shortestArea => _shortestArea;

  double get heading1 => _heading1;
  double get heading2 => _heading2;
  double get heading3 => _heading3;
  double get heading4 => _heading4;
  double get heading5 => _heading5;
  double get heading6 => _heading6;

  double get subtitle1 => _subtitle1;
  double get subtitle2 => _subtitle2;

  double get bodyText1 => _bodyText1;
  double get bodyText2 => _bodyText2;

  double get button => _button;
  double get caption => _caption;
  double get overline => _overline;

  double get icon1 => _icon1;
  double get icon2 => _icon2;
  double get icon3 => _icon3;

  double get toolbarHeight => _toolbarHeight;
}
