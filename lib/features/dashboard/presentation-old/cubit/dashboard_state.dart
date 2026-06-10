import 'package:equatable/equatable.dart';
import 'package:d2ybank/core/errors/failures.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import '../../domain/entities/dashboard_entities.dart';

class DashboardState extends Equatable {
  final StateStatus status;
  final AccountEntity? account;
  final List<QuickActionEntity> quickActions;
  final List<ExclusiveServiceEntity> exclusiveServices;
  final List<EWalletEntity> eWallets;
  final List<PromoEntity> promos;
  final List<ProductEntity> products;
  final Failure? failure;
  final bool balanceVisible;

  const DashboardState({
    this.status = StateStatus.initial,
    this.account,
    this.quickActions = const [],
    this.exclusiveServices = const [],
    this.eWallets = const [],
    this.promos = const [],
    this.products = const [],
    this.failure,
    this.balanceVisible = true,
  });

  DashboardState copyWith({
    StateStatus? status,
    AccountEntity? account,
    List<QuickActionEntity>? quickActions,
    List<ExclusiveServiceEntity>? exclusiveServices,
    List<EWalletEntity>? eWallets,
    List<PromoEntity>? promos,
    List<ProductEntity>? products,
    Failure? failure,
    bool? balanceVisible,
  }) {
    return DashboardState(
      status: status ?? this.status,
      account: account ?? this.account,
      quickActions: quickActions ?? this.quickActions,
      exclusiveServices: exclusiveServices ?? this.exclusiveServices,
      eWallets: eWallets ?? this.eWallets,
      promos: promos ?? this.promos,
      products: products ?? this.products,
      failure: failure ?? this.failure,
      balanceVisible: balanceVisible ?? this.balanceVisible,
    );
  }

  @override
  List<Object?> get props => [
    status, account, quickActions, exclusiveServices,
    eWallets, promos, products, failure, balanceVisible,
  ];
}