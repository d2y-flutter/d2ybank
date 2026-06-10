import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'package:d2ybank/shared/components/inputs/d2y_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';

class CountryCodeItem {
  final String countryName;
  final String flagEmoji;
  final String dialCode;

  const CountryCodeItem({
    required this.countryName,
    required this.flagEmoji,
    required this.dialCode,
  });
}

class D2YCountryPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? errorText;
  final ValueChanged<CountryCodeItem>? onCountryChanged;
  final ValueChanged<String>? onChanged;

  const D2YCountryPhoneField({
    super.key,
    required this.controller,
    this.focusNode,
    this.errorText,
    this.onCountryChanged,
    this.onChanged,
  });

  @override
  State<D2YCountryPhoneField> createState() => _D2YCountryPhoneFieldState();
}

class _D2YCountryPhoneFieldState extends State<D2YCountryPhoneField> {
  CountryCodeItem _selectedCountry = const CountryCodeItem(
    countryName: 'Indonesia',
    flagEmoji: '🇮🇩',
    dialCode: '+62',
  );

  final List<CountryCodeItem> _countries = const [
    CountryCodeItem(countryName: 'Indonesia', flagEmoji: '🇮🇩', dialCode: '+62'),
    CountryCodeItem(countryName: 'Malaysia', flagEmoji: '🇲🇾', dialCode: '+60'),
    CountryCodeItem(countryName: 'Singapore', flagEmoji: '🇸🇬', dialCode: '+65'),
    CountryCodeItem(countryName: 'Thailand', flagEmoji: '🇹🇭', dialCode: '+66'),
  ];

  bool get _hasError => widget.errorText != null && widget.errorText!.isNotEmpty;

  Future<void> _showCountryPicker() async {
    final selected = await showModalBottomSheet<CountryCodeItem>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilih Kode Negara',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ..._countries.map(
                  (country) => _CountryOptionTile(
                    item: country,
                    isSelected: country.dialCode == _selectedCountry.dialCode,
                    onTap: () => Navigator.pop(context, country),
                  ),
                ),
                const SizedBox(height: 12),
                D2YButton.text(
                  text: 'Tutup',
                  foregroundColor: AppColors.primary,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() => _selectedCountry = selected);
      widget.onCountryChanged?.call(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _hasError
        ? AppColors.error
        : AppColors.outlineVariant.withValues(alpha: 0.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nomor Ponsel',
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.primary.withValues(alpha: 0.7),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor),
            boxShadow: [
              if (!_hasError)
                BoxShadow(
                  color: AppColors.primaryContainer.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Row(
            children: [
              InkWell(
                onTap: _showCountryPicker,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(18),
                ),
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.55),
                    border: Border(
                      right: BorderSide(
                        color: AppColors.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedCountry.flagEmoji,
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _selectedCountry.dialCode,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primary.withValues(alpha: 0.65),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: D2YTextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  hintText: '812 3456 7890',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  fillColor: Colors.transparent,
                  showBorder: false,
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 18,
                  ),
                  hintColor: AppColors.outlineVariant.withValues(alpha: 0.7),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(14),
                  ],
                  onChanged: widget.onChanged,
                ),
              ),
            ],
          ),
        ),
        if (_hasError) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}

class _CountryOptionTile extends StatelessWidget {
  final CountryCodeItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _CountryOptionTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColors.primary.withValues(alpha: 0.07)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Text(item.flagEmoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.countryName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                item.dialCode,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}