import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/shared/utils/formatters/currency_formatter.dart';
import '../../domain/entities/dashboard_entities.dart';

/// Premium account card: primary→primaryContainer gradient,
/// glassmorphism overlays, editorial typography.
class AccountCard extends StatelessWidget {
  final AccountEntity account;
  final bool balanceVisible;
  final VoidCallback? onToggleVisibility;

  const AccountCard({
    super.key,
    required this.account,
    this.balanceVisible = true,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Glassmorphism overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppRadius.xxl),
              ),
            ),
          ),
          // Secondary glow blob
          Positioned(
            top: -48,
            right: -48,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryFixed.withValues(alpha: 0.1),
              ),
            ),
          ),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Balance section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SALDO TERSEDIA',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.surfaceContainerHighest.withValues(alpha: 0.7),
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            balanceVisible
                                ? CurrencyFormatter.idr(account.balance)
                                : 'Rp ••••••••',
                            style: AppTextStyles.displayMedium.copyWith(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          GestureDetector(
                            onTap: onToggleVisibility,
                            child: Icon(
                              balanceVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 20,
                              color: AppColors.onPrimary.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Action circles
                  Row(
                    children: [
                      _glassCircle(Icons.credit_card_rounded),
                      const SizedBox(width: AppSpacing.xs),
                      _glassCircle(Icons.qr_code_rounded),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),
              Divider(color: AppColors.white.withValues(alpha: 0.1), height: 1),
              const SizedBox(height: AppSpacing.xl),

              // Account number + CTA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOMOR REKENING',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.surfaceContainerHighest.withValues(alpha: 0.5),
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            account.accountNumber,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: account.accountNumber));
                            },
                            child: Icon(
                              Icons.copy_rounded,
                              size: 16,
                              color: AppColors.secondaryFixedDim.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // CTA button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      'RINCIAN AKUN',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSecondaryContainer,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _glassCircle(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: 0.1),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.2),
        ),
      ),
      child: Icon(icon, color: AppColors.white, size: 18),
    );
  }
}