import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:flutter/material.dart';

import '../../bloc/kyc/kyc_state.dart';
import 'ktp_preview_section.dart';
import 'kyc_form_fields.dart';
import 'kyc_header.dart';
import 'kyc_statement_checkbox.dart';
import 'kyc_submit_section.dart';

class KycContent extends StatelessWidget {
  final KycState state;
  final TextEditingController nikController;
  final TextEditingController fullNameController;
  final TextEditingController placeOfBirthController;
  final TextEditingController addressController;
  final TextEditingController religionController;

  const KycContent({
    super.key,
    required this.state,
    required this.nikController,
    required this.fullNameController,
    required this.placeOfBirthController,
    required this.addressController,
    required this.religionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KycHeader(),
        const SizedBox(height: AppSpacing.xl),
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 760;

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 360,
                    child: KtpPreviewSection(),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: KycFormFields(
                      state: state,
                      nikController: nikController,
                      fullNameController: fullNameController,
                      placeOfBirthController: placeOfBirthController,
                      addressController: addressController,
                      religionController: religionController,
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                const KtpPreviewSection(),
                const SizedBox(height: AppSpacing.md),
                KycFormFields(
                  state: state,
                  nikController: nikController,
                  fullNameController: fullNameController,
                  placeOfBirthController: placeOfBirthController,
                  addressController: addressController,
                  religionController: religionController,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        KycStatementCheckbox(state: state),
        const SizedBox(height: AppSpacing.xl),
        KycSubmitSection(state: state),
      ],
    );
  }
}