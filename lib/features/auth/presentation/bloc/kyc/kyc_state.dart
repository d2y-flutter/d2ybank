import 'package:equatable/equatable.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import '../../../domain/entities/kyc_field.dart';

class KycState extends Equatable {
  final StateStatus status;

  final String nik;
  final String fullName;
  final String placeOfBirth;
  final DateTime? dateOfBirth;
  final String address;
  final String gender;
  final String religion;
  final bool acceptedStatement;

  final Map<KycField, String> errors;
  final String? generalError;

  const KycState({
    this.status = StateStatus.initial,
    this.nik = '',
    this.fullName = '',
    this.placeOfBirth = '',
    this.dateOfBirth,
    this.address = '',
    this.gender = '',
    this.religion = '',
    this.acceptedStatement = false,
    this.errors = const {},
    this.generalError,
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get isLoading => status == StateStatus.loading;
  bool get isSuccess => status == StateStatus.success;
  bool get isFailure => status == StateStatus.failure;

  KycState copyWith({
    StateStatus? status,
    String? nik,
    String? fullName,
    String? placeOfBirth,
    DateTime? dateOfBirth,
    String? address,
    String? gender,
    String? religion,
    bool? acceptedStatement,
    Map<KycField, String>? errors,
    String? generalError,
    bool clearGeneralError = false,
  }) {
    return KycState(
      status: status ?? this.status,
      nik: nik ?? this.nik,
      fullName: fullName ?? this.fullName,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      religion: religion ?? this.religion,
      acceptedStatement: acceptedStatement ?? this.acceptedStatement,
      errors: errors ?? this.errors,
      generalError: clearGeneralError ? null : generalError ?? this.generalError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        nik,
        fullName,
        placeOfBirth,
        dateOfBirth,
        address,
        gender,
        religion,
        acceptedStatement,
        errors,
        generalError,
      ];
}