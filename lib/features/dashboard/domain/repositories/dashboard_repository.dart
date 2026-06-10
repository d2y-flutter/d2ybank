import 'package:dartz/dartz.dart';
import 'package:d2ybank/core/errors/failures.dart';
import '../entities/dashboard_entities.dart';

/// Contract for backend team — each method = one endpoint.
abstract class DashboardRepository {
  Future<Either<Failure, AccountEntity>> getAccount();
  Future<Either<Failure, List<QuickActionEntity>>> getQuickActions();
  Future<Either<Failure, List<ExclusiveServiceEntity>>> getExclusiveServices();
  Future<Either<Failure, List<EWalletEntity>>> getEWallets();
  Future<Either<Failure, List<PromoEntity>>> getPromos();
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}