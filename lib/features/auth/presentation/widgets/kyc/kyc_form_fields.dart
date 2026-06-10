import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/shared/components/inputs/d2y_date_field.dart';
import 'package:d2ybank/shared/components/inputs/d2y_dropdown_field.dart';
import 'package:d2ybank/shared/components/inputs/d2y_text_field.dart';
import 'package:d2ybank/shared/validators/d2y_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/kyc_field.dart';
import '../../bloc/kyc/kyc_bloc.dart';
import '../../bloc/kyc/kyc_event.dart';
import '../../bloc/kyc/kyc_state.dart';

class KycFormFields extends StatelessWidget {
  final KycState state;
  final TextEditingController nikController;
  final TextEditingController fullNameController;
  final TextEditingController placeOfBirthController;
  final TextEditingController addressController;
  final TextEditingController religionController;

  const KycFormFields({
    super.key,
    required this.state,
    required this.nikController,
    required this.fullNameController,
    required this.placeOfBirthController,
    required this.addressController,
    required this.religionController,
  });

  void _changeTextField(BuildContext context, KycField field, String value) {
    context.read<KycBloc>().add(
          KycFieldChanged(field: field, value: value),
        );
  }

  void _changeDate(BuildContext context, DateTime? value) {
    context.read<KycBloc>().add(KycDateOfBirthChanged(value));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth >= 560;

        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _FieldBox(
              width: constraints.maxWidth,
              child: _textField(
                controller: nikController,
                label: 'NIK (Nomor Induk Kependudukan)',
                hint: 'Masukkan NIK',
                errorText: state.errors[KycField.nik],
                keyboardType: TextInputType.number,
                inputFormatters: D2YInputFormatters.digitsOnly(maxLength: 16),
                onChanged: (value) => _changeTextField(context, KycField.nik, value),
              ),
            ),
            _FieldBox(
              width: constraints.maxWidth,
              child: _textField(
                controller: fullNameController,
                label: 'Nama Lengkap',
                hint: 'Masukkan nama lengkap',
                errorText: state.errors[KycField.fullName],
                textCapitalization: TextCapitalization.characters,
                inputFormatters: D2YInputFormatters.uppercase(maxLength: 80),
                onChanged: (value) => _changeTextField(context, KycField.fullName, value),
              ),
            ),
            _FieldBox(
              width: _responsiveWidth(constraints.maxWidth, twoColumns),
              child: _textField(
                controller: placeOfBirthController,
                label: 'Tempat Lahir',
                hint: 'Masukkan tempat lahir',
                errorText: state.errors[KycField.placeOfBirth],
                textCapitalization: TextCapitalization.characters,
                inputFormatters: D2YInputFormatters.uppercase(maxLength: 60),
                onChanged: (value) =>
                    _changeTextField(context, KycField.placeOfBirth, value),
              ),
            ),
            _FieldBox(
              width: _responsiveWidth(constraints.maxWidth, twoColumns),
              child: D2YDateField(
                value: state.dateOfBirth,
                labelText: 'Tanggal Lahir',
                hintText: 'Pilih tanggal lahir',
                isRequired: true,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                errorText: state.errors[KycField.dateOfBirth],
                fillColor: AppColors.white,
                borderColor: state.errors[KycField.dateOfBirth] != null
                    ? AppColors.error
                    : AppColors.outlineVariant,
                focusedBorderColor: AppColors.primary,
                borderRadius: AppRadius.lg,
                onChanged: (value) => _changeDate(context, value),
              ),
            ),
            _FieldBox(
              width: constraints.maxWidth,
              child: _textField(
                controller: addressController,
                label: 'Alamat Sesuai KTP',
                hint: 'Masukkan alamat sesuai KTP',
                errorText: state.errors[KycField.address],
                maxLines: 3,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: D2YInputFormatters.uppercase(maxLength: 160),
                onChanged: (value) => _changeTextField(context, KycField.address, value),
              ),
            ),
            _FieldBox(
              width: _responsiveWidth(constraints.maxWidth, twoColumns),
              child: D2YDropdownField<String>(
                value: state.gender.isEmpty ? null : state.gender,
                labelText: 'Jenis Kelamin',
                hintText: 'Pilih jenis kelamin',
                sheetTitle: 'Jenis Kelamin',
                isRequired: true,
                fillColor: AppColors.white,
                borderColor: state.errors[KycField.gender] != null
                    ? AppColors.error
                    : AppColors.outlineVariant,
                focusedBorderColor: AppColors.primary,
                errorText: state.errors[KycField.gender],
                items: const [
                  D2YDropdownItem(value: 'LAKI-LAKI', label: 'LAKI-LAKI'),
                  D2YDropdownItem(value: 'PEREMPUAN', label: 'PEREMPUAN'),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  _changeTextField(context, KycField.gender, value);
                },
              ),
            ),
            _FieldBox(
              width: _responsiveWidth(constraints.maxWidth, twoColumns),
              child: _textField(
                controller: religionController,
                label: 'Agama',
                hint: 'Masukkan agama',
                errorText: state.errors[KycField.religion],
                textCapitalization: TextCapitalization.characters,
                inputFormatters: D2YInputFormatters.uppercase(maxLength: 30),
                onChanged: (value) => _changeTextField(context, KycField.religion, value),
              ),
            ),
          ],
        );
      },
    );
  }

  double _responsiveWidth(double maxWidth, bool twoColumns) {
    if (!twoColumns) return maxWidth;
    return (maxWidth - AppSpacing.sm) / 2;
  }

  D2YTextField _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? errorText,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return D2YTextField(
      controller: controller,
      labelText: label,
      hintText: hint,
      isRequired: true,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      errorText: errorText,
      onChanged: onChanged,
      fillColor: AppColors.white,
      borderColor: errorText != null ? AppColors.error : AppColors.outlineVariant,
      focusedBorderColor: AppColors.primary,
      borderRadius: AppRadius.lg,
      suffixIcon: const Icon(
        Icons.edit_rounded,
        color: AppColors.outlineVariant,
        size: 20,
      ),
    );
  }
}

class _FieldBox extends StatelessWidget {
  final double width;
  final Widget child;

  const _FieldBox({
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: child);
  }
}