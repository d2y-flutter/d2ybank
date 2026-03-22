import 'package:flutter/material.dart';

abstract final class AppShadow {
  static const List<BoxShadow> none = [];
  static const List<BoxShadow> xs = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1))];
  static const List<BoxShadow> sm = [
    BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2))];
  static const List<BoxShadow> md = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 4))];
  static const List<BoxShadow> lg = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 24, offset: Offset(0, 8))];
  static List<BoxShadow> colored(Color color, {double opacity = 0.3}) => [
    BoxShadow(color: color.withValues(alpha: opacity), blurRadius: 16, offset: const Offset(0, 4))];
}
