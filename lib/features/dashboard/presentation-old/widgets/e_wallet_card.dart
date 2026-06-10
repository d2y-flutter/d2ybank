import 'package:flutter/material.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/shared/utils/formatters/currency_formatter.dart';
import '../../domain/entities/dashboard_entities.dart';

/// e-Wallet Central card from the HTML bento grid.
class EWalletCard extends StatelessWidget {
  final List<EWalletEntity> wallets;

  const EWalletCard({super.key, required this.wallets});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'e-Wallet Central',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(Icons.account_balance_wallet_outlined, color: AppColors.outline, size: 20),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Wallet list (spacing-only separation — no dividers per design doc)
          ...wallets.asMap().entries.map((entry) {
            final wallet = entry.value;
            final isLast = entry.key == wallets.length - 1;
            return Column(
              children: [
                _WalletRow(wallet: wallet),
                if (!isLast) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    height: 0.5,
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ],
            );
          }),

          const SizedBox(height: AppSpacing.lg),

          // Link wallet button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
              child: Text(
                'HUBUNGKAN WALLET',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletRow extends StatelessWidget {
  final EWalletEntity wallet;

  const _WalletRow({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Colored circle avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: wallet.color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                wallet.abbreviation,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            wallet.name,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            CurrencyFormatter.idr(wallet.balance),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}