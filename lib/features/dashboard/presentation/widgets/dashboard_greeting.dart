import 'package:flutter/material.dart';

import 'dashboard_ui_tokens.dart';

class DashboardGreeting extends StatelessWidget {
  const DashboardGreeting({
    required this.userName,
    this.greeting,
    super.key,
  });

  final String userName;
  final String? greeting;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting ?? _resolveGreeting(DateTime.now()),
          style: const TextStyle(
            fontFamily: 'DMSans',
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w500,
            color: DashboardUiTokens.onSurfaceVariant,
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(height: DashboardUiTokens.gapXs),
        Text(
          userName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 24,
            height: 1.25,
            fontWeight: FontWeight.w800,
            color: DashboardUiTokens.primary,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  static String _resolveGreeting(DateTime now) {
    final hour = now.hour;
    if (hour < 11) return 'Selamat Pagi,';
    if (hour < 15) return 'Selamat Siang,';
    if (hour < 18) return 'Selamat Sore,';
    return 'Selamat Malam,';
  }
}
