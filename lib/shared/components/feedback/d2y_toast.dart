import 'dart:async';
import 'dart:ui';

import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_shadow.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

enum D2YToastType {
  success,
  error,
  warning,
  info,
}

class D2YToast {
  static OverlayEntry? _activeEntry;

  static void success(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      type: D2YToastType.success,
      title: title,
      description: description,
      duration: duration,
    );
  }

  static void error(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      type: D2YToastType.error,
      title: title,
      description: description,
      duration: duration,
    );
  }

  static void warning(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      type: D2YToastType.warning,
      title: title,
      description: description,
      duration: duration,
    );
  }

  static void info(
    BuildContext context, {
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      type: D2YToastType.info,
      title: title,
      description: description,
      duration: duration,
    );
  }

  static void show(
    BuildContext context, {
    required D2YToastType type,
    required String title,
    String? description,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Navigator.of(context, rootNavigator: true).overlay;

    if (overlay == null) return;

    _activeEntry?.remove();
    _activeEntry = null;

    late final OverlayEntry entry;

    void remove() {
      if (entry.mounted) {
        entry.remove();
      }

      if (_activeEntry == entry) {
        _activeEntry = null;
      }
    }

    entry = OverlayEntry(
      builder: (context) {
        return _D2YToastOverlay(
          type: type,
          title: title,
          description: description,
          duration: duration,
          onDismissed: remove,
        );
      },
    );

    _activeEntry = entry;
    overlay.insert(entry);
  }
}

class _D2YToastOverlay extends StatefulWidget {
  final D2YToastType type;
  final String title;
  final String? description;
  final Duration duration;
  final VoidCallback onDismissed;

  const _D2YToastOverlay({
    required this.type,
    required this.title,
    required this.description,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_D2YToastOverlay> createState() => _D2YToastOverlayState();
}

class _D2YToastOverlayState extends State<_D2YToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  Timer? _timer;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
      reverseDuration: const Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInCubic,
    );

    _slideAnimation = Tween<double>(
      begin: -96,
      end: 0,
    ).animate(curvedAnimation);

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.55, curve: Curves.easeOut),
        reverseCurve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1,
    ).animate(curvedAnimation);

    _controller.forward();

    _timer = Timer(widget.duration, _dismiss);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    if (_isClosing) return;

    _isClosing = true;
    _timer?.cancel();

    await _controller.reverse();

    if (mounted) {
      widget.onDismissed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.viewPaddingOf(context).top;

    return Positioned(
      top: topPadding + AppSpacing.xs,
      left: AppSpacing.md,
      right: AppSpacing.md,
      child: IgnorePointer(
        ignoring: false,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  alignment: Alignment.topCenter,
                  child: child,
                ),
              ),
            );
          },
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _dismiss,
                onVerticalDragEnd: (details) {
                  final velocity = details.primaryVelocity ?? 0;

                  if (velocity < -80) {
                    _dismiss();
                  }
                },
                child: Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDED).withValues(alpha: 0.78),
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.55),
                          ),
                          boxShadow: [
                            ...AppShadow.colored(
                              AppColors.onBackground,
                              opacity: 0.14,
                            ),
                            BoxShadow(
                              color: AppColors.white.withValues(alpha: 0.18),
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ToastIcon(type: widget.type),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: _ToastText(
                                title: widget.title,
                                description: widget.description,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Icon(
                              Icons.close_rounded,
                              color: AppColors.onSurface.withValues(alpha: 0.42),
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastIcon extends StatelessWidget {
  final D2YToastType type;

  const _ToastIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final config = _ToastIconConfig.fromType(type);

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: config.backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        config.icon,
        color: config.iconColor,
        size: 21,
      ),
    );
  }
}

class _ToastText extends StatelessWidget {
  final String title;
  final String? description;

  const _ToastText({
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final hasDescription = description != null && description!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w800,
            height: 1.25,
          ),
        ),
        if (hasDescription) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            description!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurface.withValues(alpha: 0.78),
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ],
      ],
    );
  }
}

class _ToastIconConfig {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const _ToastIconConfig({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  factory _ToastIconConfig.fromType(D2YToastType type) {
    switch (type) {
      case D2YToastType.success:
        return _ToastIconConfig(
          icon: Icons.check_circle_rounded,
          iconColor: AppColors.primary,
          backgroundColor: AppColors.primaryFixedDim.withValues(alpha: 0.28),
        );

      case D2YToastType.error:
        return _ToastIconConfig(
          icon: Icons.error_rounded,
          iconColor: AppColors.error,
          backgroundColor: AppColors.errorContainer.withValues(alpha: 0.85),
        );

      case D2YToastType.warning:
        return _ToastIconConfig(
          icon: Icons.warning_rounded,
          iconColor: AppColors.secondary,
          backgroundColor: AppColors.secondaryFixed.withValues(alpha: 0.75),
        );

      case D2YToastType.info:
        return _ToastIconConfig(
          icon: Icons.info_rounded,
          iconColor: AppColors.surfaceTint,
          backgroundColor: AppColors.outline.withValues(alpha: 0.22),
        );
    }
  }
}