import 'package:dartz/dartz.dart';
import '../entities/kyc_form_entity.dart';
import '../repositories/kyc_repository.dart';

class SubmitKycUseCase {
  final KycRepository repository;

  SubmitKycUseCase(this.repository);

  Future<Either<String, KycFormEntity>> call(KycFormEntity data) {
    return repository.submitKycData(data);
  }
}