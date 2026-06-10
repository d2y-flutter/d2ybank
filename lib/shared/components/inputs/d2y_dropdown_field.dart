import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_radius.dart';
import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import 'd2y_text_field.dart';

class D2YDropdownItem<T> {
  final T value;
  final String label;

  const D2YDropdownItem({
    required this.value,
    required this.label,
  });
}

class D2YDropdownField<T> extends StatefulWidget {
  final T? value;
  final List<D2YDropdownItem<T>> items;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final bool isRequired;
  final ValueChanged<T?>? onChanged;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String sheetTitle;
  final String cancelText;
  final String doneText;

  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final TextStyle? labelStyle;
  final TextStyle? style;

  const D2YDropdownField({
    super.key,
    required this.items,
    this.value,
    this.labelText,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.isRequired = false,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.sheetTitle = 'Pilih Data',
    this.cancelText = 'Batal',
    this.doneText = 'Selesai',
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.contentPadding,
    this.borderRadius,
    this.labelStyle,
    this.style,
  });

  @override
  State<D2YDropdownField<T>> createState() => _D2YDropdownFieldState<T>();
}

class _D2YDropdownFieldState<T> extends State<D2YDropdownField<T>> {
  late final TextEditingController _controller;

  String get _selectedLabel {
    if (widget.value == null) return '';

    final selected = widget.items.where((item) => item.value == widget.value);

    if (selected.isEmpty) return '';

    return selected.first.label;
  }

  int get _selectedIndex {
    if (widget.value == null) return 0;

    final index = widget.items.indexWhere((item) => item.value == widget.value);

    return index < 0 ? 0 : index;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _selectedLabel);
  }

  @override
  void didUpdateWidget(covariant D2YDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value || oldWidget.items != widget.items) {
      _controller.text = _selectedLabel;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openPicker() async {
    if (!widget.enabled || widget.items.isEmpty) return;

    var selectedIndex = _selectedIndex;

    final result = await showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.onBackground.withValues(alpha: 0.28),
      builder: (context) {
        return _CupertinoPickerSheet<T>(
          title: widget.sheetTitle,
          cancelText: widget.cancelText,
          doneText: widget.doneText,
          items: widget.items,
          initialIndex: selectedIndex,
          onSelectedItemChanged: (index) {
            selectedIndex = index;
          },
        );
      },
    );

    if (result != null) {
      widget.onChanged?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.errorText != null
        ? AppColors.error
        : widget.borderColor ?? AppColors.outlineVariant;

    return D2YTextField(
      controller: _controller,
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: widget.errorText,
      enabled: widget.enabled,
      readOnly: true,
      isRequired: widget.isRequired,
      onTap: _openPicker,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon ??
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primary,
            size: 22,
          ),
      fillColor: widget.fillColor,
      borderColor: borderColor,
      focusedBorderColor: widget.focusedBorderColor ?? AppColors.primary,
      contentPadding: widget.contentPadding,
      borderRadius: widget.borderRadius ?? AppRadius.lg,
      style: widget.style ??
          AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
      labelStyle: widget.labelStyle,
    );
  }
}

class _CupertinoPickerSheet<T> extends StatefulWidget {
  final String title;
  final String cancelText;
  final String doneText;
  final List<D2YDropdownItem<T>> items;
  final int initialIndex;
  final ValueChanged<int> onSelectedItemChanged;

  const _CupertinoPickerSheet({
    required this.title,
    required this.cancelText,
    required this.doneText,
    required this.items,
    required this.initialIndex,
    required this.onSelectedItemChanged,
  });

  @override
  State<_CupertinoPickerSheet<T>> createState() => _CupertinoPickerSheetState<T>();
}

class _CupertinoPickerSheetState<T> extends State<_CupertinoPickerSheet<T>> {
  late int _selectedIndex;
  late final FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex;
    _scrollController = FixedExtentScrollController(
      initialItem: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pop(widget.items[_selectedIndex].value);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppRadius.xxl),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.only(bottom: bottomPadding),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.92),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.xxl),
            ),
            border: Border(
              top: BorderSide(
                color: AppColors.white.withValues(alpha: 0.55),
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSpacing.sm),
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _PickerSheetHeader(
                  title: widget.title,
                  cancelText: widget.cancelText,
                  doneText: widget.doneText,
                  onCancel: () => Navigator.of(context).pop(),
                  onDone: _submit,
                ),
                SizedBox(
                  height: 216,
                  child: CupertinoPicker(
                    scrollController: _scrollController,
                    itemExtent: 44,
                    magnification: 1.08,
                    squeeze: 1.08,
                    useMagnifier: true,
                    selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                      background: Color(0x1A003527),
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() => _selectedIndex = index);
                      widget.onSelectedItemChanged(index);
                    },
                    children: widget.items.map((item) {
                      return Center(
                        child: Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PickerSheetHeader extends StatelessWidget {
  final String title;
  final String cancelText;
  final String doneText;
  final VoidCallback onCancel;
  final VoidCallback onDone;

  const _PickerSheetHeader({
    required this.title,
    required this.cancelText,
    required this.doneText,
    required this.onCancel,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          _SheetActionButton(
            text: cancelText,
            onTap: onCancel,
            color: AppColors.onSurfaceVariant,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          _SheetActionButton(
            text: doneText,
            onTap: onDone,
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ],
      ),
    );
  }
}

class _SheetActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final FontWeight fontWeight;

  const _SheetActionButton({
    required this.text,
    required this.onTap,
    required this.color,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 36,
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Text(
        text,
        style: AppTextStyles.labelLarge.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}