import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double full = 999;

  static final BorderRadius borderRadiusXs = BorderRadius.circular(xs);
  static final BorderRadius borderRadiusSm = BorderRadius.circular(sm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(md);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(lg);
  static final BorderRadius borderRadiusXl = BorderRadius.circular(xl);
  static final BorderRadius borderRadiusFull = BorderRadius.circular(full);
  static final BorderRadius topLg = const BorderRadius.only(
    topLeft: Radius.circular(16), topRight: Radius.circular(16));
  static final BorderRadius topXl = const BorderRadius.only(
    topLeft: Radius.circular(20), topRight: Radius.circular(20));
}
