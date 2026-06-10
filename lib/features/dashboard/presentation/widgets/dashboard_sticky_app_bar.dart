import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'dashboard_ui_tokens.dart';

class DashboardStickyAppBar extends StatelessWidget {
  const DashboardStickyAppBar({
    this.profileImageUrl,
    this.onHelpTap,
    this.onProfileTap,
    super.key,
  });

  final String? profileImageUrl;
  final VoidCallback? onHelpTap;
  final VoidCallback? onProfileTap;

  static const _defaultProfileImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=300&auto=format&fit=crop';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DashboardUiTokens.surface,
      elevation: 0,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: DashboardUiTokens.maxContentWidth,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DashboardUiTokens.marginMobile,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'd2ybank',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 24,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                          color: DashboardUiTokens.primary,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onHelpTap,
                      icon: const Icon(Icons.help_outline_rounded),
                      color: DashboardUiTokens.primary,
                      tooltip: 'Bantuan',
                    ),
                    const SizedBox(width: DashboardUiTokens.gapSm),
                    InkWell(
                      onTap: onProfileTap,
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: DashboardUiTokens.secondaryContainer,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: profileImageUrl ?? _defaultProfileImage,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => const ColoredBox(
                                  color: DashboardUiTokens.surfaceContainerHigh,
                                ),
                                errorWidget: (_, __, ___) => const Icon(
                                  Icons.person_rounded,
                                  color: DashboardUiTokens.primary,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: DashboardUiTokens.success,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: DashboardUiTokens.surface,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
