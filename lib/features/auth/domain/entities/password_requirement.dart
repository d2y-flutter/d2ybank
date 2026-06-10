import 'package:equatable/equatable.dart';

class PasswordRequirement extends Equatable {
  final bool hasMinLength;
  final bool hasUpperAndLowerCase;
  final bool hasNumber;
  final bool hasSpecialCharacter;
  final bool isMatch;

  const PasswordRequirement({
    this.hasMinLength = false,
    this.hasUpperAndLowerCase = false,
    this.hasNumber = false,
    this.hasSpecialCharacter = false,
    this.isMatch = false,
  });

  bool get isStrongPassword =>
      hasMinLength &&
      hasUpperAndLowerCase &&
      hasNumber &&
      hasSpecialCharacter;

  bool get isValid => isStrongPassword && isMatch;

  factory PasswordRequirement.from({
    required String password,
    required String confirmPassword,
  }) {
    final hasMinLength = password.length >= 8;
    final hasUpperAndLowerCase =
        RegExp(r'[a-z]').hasMatch(password) && RegExp(r'[A-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialCharacter =
        RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]~`]').hasMatch(password);

    return PasswordRequirement(
      hasMinLength: hasMinLength,
      hasUpperAndLowerCase: hasUpperAndLowerCase,
      hasNumber: hasNumber,
      hasSpecialCharacter: hasSpecialCharacter,
      isMatch: confirmPassword.isNotEmpty && password == confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
        hasMinLength,
        hasUpperAndLowerCase,
        hasNumber,
        hasSpecialCharacter,
        isMatch,
      ];
}