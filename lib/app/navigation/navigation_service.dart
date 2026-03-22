import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class NavigationService {
  static void push(BuildContext context, String path, {Object? extra}) => context.push(path, extra: extra);
  static void go(BuildContext context, String path, {Object? extra}) => context.go(path, extra: extra);
  static void pop<T>(BuildContext context, [T? result]) => context.pop(result);
}
