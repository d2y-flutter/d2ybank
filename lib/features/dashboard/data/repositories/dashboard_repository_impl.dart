import 'package:dartz/dartz.dart';
import 'package:d2ybank/core/errors/failures.dart';
import '../../domain/entities/dashboard_entities.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource dataSource;

  DashboardRepositoryImpl({required this.dataSource});

  Future<Either<Failure, T>> _safe<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> getAccount() =>
      _safe(() => dataSource.getAccount());

  @override
  Future<Either<Failure, List<QuickActionEntity>>> getQuickActions() =>
      _safe(() => dataSource.getQuickActions());

  @override
  Future<Either<Failure, List<ExclusiveServiceEntity>>> getExclusiveServices() =>
      _safe(() => dataSource.getExclusiveServices());

  @override
  Future<Either<Failure, List<EWalletEntity>>> getEWallets() =>
      _safe(() => dataSource.getEWallets());

  @override
  Future<Either<Failure, List<PromoEntity>>> getPromos() =>
      _safe(() => dataSource.getPromos());

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() =>
      _safe(() => dataSource.getProducts());
}