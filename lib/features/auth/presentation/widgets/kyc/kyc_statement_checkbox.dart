import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/kyc/kyc_bloc.dart';
import '../../bloc/kyc/kyc_event.dart';
import '../../bloc/kyc/kyc_state.dart';

class KycStatementCheckbox extends StatelessWidget {
  final KycState state;

  const KycStatementCheckbox({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<KycBloc>().add(
              KycStatementChanged(!state.acceptedStatement),
            );
      },
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: state.acceptedStatement,
            activeColor: AppColors.primary,
            onChanged: (value) {
              context.read<KycBloc>().add(
                    KycStatementChanged(value ?? false),
                  );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 11),
              child: Text(
                'Saya menyatakan bahwa data di atas benar dan sesuai dengan dokumen identitas asli saya.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}