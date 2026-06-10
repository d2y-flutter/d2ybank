import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_radius.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import 'd2y_text_field.dart';

class D2YDateField extends StatefulWidget {
  final DateTime? value;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final bool isRequired;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? dateFormat;
  final ValueChanged<DateTime?> onChanged;

  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderRadius;

  const D2YDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.isRequired = false,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
  });

  @override
  State<D2YDateField> createState() => _D2YDateFieldState();
}

class _D2YDateFieldState extends State<D2YDateField> {
  late final TextEditingController _controller;

  DateFormat get _formatter => widget.dateFormat ?? DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _displayText(widget.value));
  }

  @override
  void didUpdateWidget(covariant D2YDateField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _controller.text = _displayText(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _displayText(DateTime? date) {
    if (date == null) return '';
    return _formatter.format(date);
  }

  Future<void> _openPicker() async {
    if (!widget.enabled) return;

    final now = DateTime.now();

    final result = await showCalendarDatePicker2Dialog(
      context: context,
      dialogSize: const Size(340, 420),
      borderRadius: BorderRadius.circular(AppRadius.xl),
      value: [widget.value],
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        firstDate: widget.firstDate ?? DateTime(1900),
        lastDate: widget.lastDate ?? now,
        currentDate: widget.value ?? now,
        selectedDayHighlightColor: AppColors.primary,
        selectedDayTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.w800,
        ),
        dayTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.onSurface,
          fontWeight: FontWeight.w600,
        ),
        weekdayLabelTextStyle: AppTextStyles.labelSmall.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.w800,
        ),
        controlsTextStyle: AppTextStyles.titleMedium.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
        yearTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.onSurface,
        ),
        selectedYearTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.w800,
        ),
        centerAlignModePicker: true,
      ),
    );

    final selected = result?.whereType<DateTime>().firstOrNull;

    if (selected != null) {
      widget.onChanged(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return D2YTextField(
      controller: _controller,
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: widget.errorText,
      enabled: widget.enabled,
      readOnly: true,
      isRequired: widget.isRequired,
      onTap: _openPicker,
      fillColor: widget.fillColor,
      borderColor: widget.errorText != null
          ? AppColors.error
          : widget.borderColor ?? AppColors.outlineVariant,
      focusedBorderColor: widget.focusedBorderColor ?? AppColors.primary,
      borderRadius: widget.borderRadius ?? AppRadius.lg,
      suffixIcon: const Icon(
        Icons.calendar_month_rounded,
        color: AppColors.primary,
        size: 20,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

extension _FirstOrNullDateExtension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}