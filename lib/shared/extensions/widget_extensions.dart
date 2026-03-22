import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget padAll(double p) => Padding(padding: EdgeInsets.all(p), child: this);
  Widget padH(double p) => Padding(padding: EdgeInsets.symmetric(horizontal: p), child: this);
  Widget padV(double p) => Padding(padding: EdgeInsets.symmetric(vertical: p), child: this);
  Widget get centered => Center(child: this);
  Widget get expanded => Expanded(child: this);
  Widget onTap(VoidCallback? onTap) => GestureDetector(onTap: onTap, child: this);
}
