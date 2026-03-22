import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:d2ybank/core/config/app_theme.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {ThemeData? theme}) async {
    await pumpWidget(MaterialApp(theme: theme ?? AppTheme.light, home: widget));
    await pump();
  }
}
