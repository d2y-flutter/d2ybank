import 'package:flutter/services.dart';

class D2YValidationRule {
  final bool required;
  final bool isEmail;
  final bool isFullName;
  final bool isPassword;
  final bool isNik;
  final bool isPhone;
  final bool isDateDdMmYyyy;
  final int? minLength;
  final int? maxLength;
  final RegExp? pattern;
  final String? fieldName;
  final String? customMessage;

  const D2YValidationRule({
    this.required = false,
    this.isEmail = false,
    this.isFullName = false,
    this.isPassword = false,
    this.isNik = false,
    this.isPhone = false,
    this.isDateDdMmYyyy = false,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.fieldName,
    this.customMessage,
  });
}

abstract final class D2YFieldValidator {
  static String? validate(
    String? value, {
    required D2YValidationRule rule,
  }) {
    final text = value?.trim() ?? '';
    final fieldName = rule.fieldName ?? 'Field';

    if (rule.required && text.isEmpty) {
      return rule.customMessage ?? '$fieldName wajib diisi.';
    }

    if (text.isEmpty) return null;

    if (rule.minLength != null && text.length < rule.minLength!) {
      return '$fieldName minimal ${rule.minLength} karakter.';
    }

    if (rule.maxLength != null && text.length > rule.maxLength!) {
      return '$fieldName maksimal ${rule.maxLength} karakter.';
    }

    if (rule.isEmail && !_isValidEmail(text)) {
      return 'Format email tidak valid.';
    }

    if (rule.isFullName && !_isValidFullName(text)) {
      return '$fieldName harus berisi minimal dua kata dan hanya huruf.';
    }

    if (rule.isPassword && !_isValidPassword(text)) {
      return '$fieldName minimal 8 karakter, mengandung huruf dan angka.';
    }

    if (rule.isNik && !_isValidNik(text)) {
      return 'NIK harus terdiri dari 16 digit angka.';
    }

    if (rule.isPhone && !_isValidPhone(text)) {
      return 'Nomor ponsel tidak valid.';
    }

    if (rule.isDateDdMmYyyy && !_isValidDateDdMmYyyy(text)) {
      return '$fieldName harus berformat DD-MM-YYYY.';
    }

    if (rule.pattern != null && !rule.pattern!.hasMatch(text)) {
      return rule.customMessage ?? '$fieldName tidak valid.';
    }

    return null;
  }

  static bool _isValidEmail(String value) {
    return RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value);
  }

  static bool _isValidFullName(String value) {
    return RegExp(r"^[a-zA-ZÀ-ÿ' .-]+$").hasMatch(value) &&
        value.trim().split(RegExp(r'\s+')).length >= 2;
  }

  static bool _isValidPassword(String value) {
    return value.length >= 8 &&
        RegExp(r'[A-Za-z]').hasMatch(value) &&
        RegExp(r'\d').hasMatch(value);
  }

  static bool _isValidNik(String value) {
    return RegExp(r'^\d{16}$').hasMatch(value);
  }

  static bool _isValidPhone(String value) {
    return RegExp(r'^\+?\d{9,15}$').hasMatch(value);
  }

  static bool _isValidDateDdMmYyyy(String value) {
    final match = RegExp(r'^(\d{2})-(\d{2})-(\d{4})$').firstMatch(value);
    if (match == null) return false;

    final day = int.tryParse(match.group(1)!);
    final month = int.tryParse(match.group(2)!);
    final year = int.tryParse(match.group(3)!);

    if (day == null || month == null || year == null) return false;
    if (year < 1900 || year > DateTime.now().year) return false;
    if (month < 1 || month > 12) return false;

    final lastDay = DateTime(year, month + 1, 0).day;
    return day >= 1 && day <= lastDay;
  }
}

abstract final class D2YInputFormatters {
  static List<TextInputFormatter> digitsOnly({int? maxLength}) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  static List<TextInputFormatter> uppercase({int? maxLength}) {
    return [
      TextInputFormatter.withFunction(
        (oldValue, newValue) {
          return newValue.copyWith(
            text: newValue.text.toUpperCase(),
            selection: newValue.selection,
          );
        },
      ),
      if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
    ];
  }
}