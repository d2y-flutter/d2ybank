import 'package:dartz/dartz.dart';

import '../../domain/entities/kyc_form_entity.dart';
import '../../domain/repositories/kyc_repository.dart';

class KycRepositoryImpl implements KycRepository {
  @override
  Future<Either<String, KycFormEntity>> submitKycData(KycFormEntity data) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!data.acceptedStatement) {
      return left('Silakan setujui pernyataan data terlebih dahulu.');
    }

    return right(data);
  }
}