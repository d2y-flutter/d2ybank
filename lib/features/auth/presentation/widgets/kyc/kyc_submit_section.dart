import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/kyc/kyc_bloc.dart';
import '../../bloc/kyc/kyc_event.dart';
import '../../bloc/kyc/kyc_state.dart';

class KycSubmitSection extends StatelessWidget {
  final KycState state;

  const KycSubmitSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        D2YButton(
          text: state.isLoading
              ? 'Memproses...'
              : state.isSuccess
                  ? 'Data Berhasil Disimpan'
                  : 'Konfirmasi & Lanjut',
          isLoading: state.isLoading,
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: AppColors.onPrimary,
          suffixIcon: Icon(
            state.isSuccess
                ? Icons.check_circle_rounded
                : Icons.arrow_forward_rounded,
            color: AppColors.onPrimary,
            size: AppIconSize.sm,
          ),
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<KycBloc>().add(const KycSubmitted());
                },
        ),
        const SizedBox(height: AppSpacing.md),
        Text.rich(
          TextSpan(
            text: 'Membutuhkan bantuan? ',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            children: [
              TextSpan(
                text: 'Hubungi Support',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}