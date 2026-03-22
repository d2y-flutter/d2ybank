import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import 'd2y_text_field.dart';

class D2YPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  const D2YPasswordField({super.key, this.controller, this.labelText, this.hintText = 'Enter password',
    this.errorText, this.onChanged, this.validator, this.textInputAction, this.focusNode});

  @override
  State<D2YPasswordField> createState() => _D2YPasswordFieldState();
}

class _D2YPasswordFieldState extends State<D2YPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return D2YTextField(
      controller: widget.controller, labelText: widget.labelText, hintText: widget.hintText,
      errorText: widget.errorText, obscureText: _obscured, onChanged: widget.onChanged,
      validator: widget.validator, textInputAction: widget.textInputAction, focusNode: widget.focusNode,
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: GestureDetector(
        onTap: () => setState(() => _obscured = !_obscured),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Icon(_obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 20, color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight))),
    );
  }
}
