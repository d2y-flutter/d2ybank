import 'package:flutter/material.dart';
import '../../core/logging/app_logger.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { if (mounted) onInit(); });
    AppLogger.debug('${T.toString()} initState');
  }

  void onInit() {}

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) => buildPage(context);
}
