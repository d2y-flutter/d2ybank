import 'package:d2ybank/shared/base/base_bloc.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:d2ybank/shared/validators/d2y_field_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/kyc_field.dart';
import '../../../domain/entities/kyc_form_entity.dart';
import '../../../domain/usecases/submit_kyc_usecase.dart';
import 'kyc_event.dart';
import 'kyc_state.dart';

class KycBloc extends BaseBloc<KycEvent, KycState> {
  final SubmitKycUseCase submitKycUseCase;

  KycBloc({
    required this.submitKycUseCase,
  }) : super(const KycState()) {
    on<KycFieldChanged>(_onFieldChanged);
    on<KycStatementChanged>(_onStatementChanged);
    on<KycSubmitted>(_onSubmitted);
    on<KycDateOfBirthChanged>(_onDateOfBirthChanged);
  }

  static const Map<KycField, D2YValidationRule> _rules = {
    KycField.nik: D2YValidationRule(
      required: true,
      isNik: true,
      fieldName: 'NIK',
    ),
    KycField.fullName: D2YValidationRule(
      required: true,
      isFullName: true,
      fieldName: 'Nama Lengkap',
    ),
    KycField.placeOfBirth: D2YValidationRule(
      required: true,
      minLength: 2,
      fieldName: 'Tempat Lahir',
    ),
    KycField.dateOfBirth: D2YValidationRule(
      required: true,
      isDateDdMmYyyy: true,
      fieldName: 'Tanggal Lahir',
    ),
    KycField.address: D2YValidationRule(
      required: true,
      minLength: 10,
      fieldName: 'Alamat',
    ),
    KycField.gender: D2YValidationRule(
      required: true,
      fieldName: 'Jenis Kelamin',
    ),
    KycField.religion: D2YValidationRule(
      required: true,
      fieldName: 'Agama',
    ),
  };

  void _onFieldChanged(
    KycFieldChanged event,
    Emitter<KycState> emit,
  ) {
    final nextErrors = Map<KycField, String>.from(state.errors);
    final error = _validateField(event.field, event.value);

    if (error == null) {
      nextErrors.remove(event.field);
    } else {
      nextErrors[event.field] = error;
    }

    emit(
      _copyStateByField(
        state,
        event.field,
        event.value,
      ).copyWith(
        errors: nextErrors,
        status: StateStatus.initial,
        clearGeneralError: true,
      ),
    );
  }

  void _onStatementChanged(
    KycStatementChanged event,
    Emitter<KycState> emit,
  ) {
    emit(
      state.copyWith(
        acceptedStatement: event.value,
        status: StateStatus.initial,
        clearGeneralError: true,
      ),
    );
  }

  Future<void> _onSubmitted(
    KycSubmitted event,
    Emitter<KycState> emit,
  ) async {
    final errors = _validateAll(state);

    if (errors.isNotEmpty) {
      emit(
        state.copyWith(
          status: StateStatus.failure,
          errors: errors,
          generalError: 'Periksa kembali data yang Anda masukkan.',
        ),
      );
      return;
    }

    if (!state.acceptedStatement) {
      emit(
        state.copyWith(
          status: StateStatus.failure,
          generalError: 'Silakan setujui pernyataan data terlebih dahulu.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: StateStatus.loading, clearGeneralError: true));

    final data = KycFormEntity(
      nik: state.nik,
      fullName: state.fullName,
      placeOfBirth: state.placeOfBirth,
      dateOfBirth: state.dateOfBirth!,
      address: state.address,
      gender: state.gender,
      religion: state.religion,
      acceptedStatement: state.acceptedStatement,
    );

    final result = await submitKycUseCase(data);

    result.fold(
      (message) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            generalError: message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            errors: const {},
            clearGeneralError: true,
          ),
        );
      },
    );
  }

  Map<KycField, String> _validateAll(KycState state) {
    final values = {
      KycField.nik: state.nik,
      KycField.fullName: state.fullName,
      KycField.placeOfBirth: state.placeOfBirth,
      KycField.address: state.address,
      KycField.gender: state.gender,
      KycField.religion: state.religion,
    };

    final errors = <KycField, String>{};

    for (final entry in values.entries) {
      final error = _validateField(entry.key, entry.value);
      if (error != null) {
        errors[entry.key] = error;
      }
    }

    if (state.dateOfBirth == null) {
      errors[KycField.dateOfBirth] = 'Tanggal Lahir wajib dipilih.';
    }

    return errors;
  }

  String? _validateField(KycField field, String value) {
    final rule = _rules[field];
    if (rule == null) return null;

    return D2YFieldValidator.validate(
      value,
      rule: rule,
    );
  }

  KycState _copyStateByField(
    KycState state,
    KycField field,
    String value,
  ) {
    switch (field) {
      case KycField.nik:
        return state.copyWith(nik: value);

      case KycField.fullName:
        return state.copyWith(fullName: value);

      case KycField.placeOfBirth:
        return state.copyWith(placeOfBirth: value);

      case KycField.dateOfBirth:
        return state;

      case KycField.address:
        return state.copyWith(address: value);

      case KycField.gender:
        return state.copyWith(gender: value);

      case KycField.religion:
        return state.copyWith(religion: value);
    }
  }

  void _onDateOfBirthChanged(
    KycDateOfBirthChanged event,
    Emitter<KycState> emit,
  ) {
    final nextErrors = Map<KycField, String>.from(state.errors);

    if (event.value == null) {
      nextErrors[KycField.dateOfBirth] = 'Tanggal Lahir wajib dipilih.';
    } else {
      nextErrors.remove(KycField.dateOfBirth);
    }

    emit(
      state.copyWith(
        dateOfBirth: event.value,
        errors: nextErrors,
        status: StateStatus.initial,
        clearGeneralError: true,
      ),
    );
  }
}