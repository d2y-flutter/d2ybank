import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/password_requirement.dart';

class PasswordRequirementPills extends StatelessWidget {
  final PasswordRequirement requirement;

  const PasswordRequirementPills({
    super.key,
    required this.requirement,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        PasswordRequirementPill(
          label: '8+ Karakter',
          isActive: requirement.hasMinLength,
        ),
        PasswordRequirementPill(
          label: 'A-a',
          isActive: requirement.hasUpperAndLowerCase,
        ),
        PasswordRequirementPill(
          label: 'Angka',
          isActive: requirement.hasNumber,
        ),
        PasswordRequirementPill(
          label: 'Simbol',
          isActive: requirement.hasSpecialCharacter,
        ),
      ],
    );
  }
}

class PasswordMatchPill extends StatelessWidget {
  final bool isMatch;

  const PasswordMatchPill({
    super.key,
    required this.isMatch,
  });

  @override
  Widget build(BuildContext context) {
    return PasswordRequirementPill(
      label: isMatch ? 'Password Cocok' : 'Password Tidak Cocok',
      isActive: isMatch,
      activeIcon: Icons.check_circle_rounded,
      inactiveIcon: Icons.error_rounded,
    );
  }
}

class PasswordRequirementPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const PasswordRequirementPill({
    super.key,
    required this.label,
    required this.isActive,
    this.activeIcon = Icons.check_circle_rounded,
    this.inactiveIcon = Icons.check_circle_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isActive ? AppColors.primaryContainer : AppColors.surfaceContainerLow;
    final foregroundColor = isActive ? AppColors.secondaryFixedDim : AppColors.outline;
    final borderColor = isActive ? AppColors.secondaryFixedDim : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? activeIcon : inactiveIcon,
            color: foregroundColor,
            size: 15,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}