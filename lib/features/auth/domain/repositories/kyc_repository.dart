import 'package:dartz/dartz.dart';
import '../entities/kyc_form_entity.dart';

abstract class KycRepository {
  Future<Either<String, KycFormEntity>> submitKycData(KycFormEntity data);
}