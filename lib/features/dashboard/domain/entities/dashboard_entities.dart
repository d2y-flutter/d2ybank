import 'dart:ui';

import 'package:d2ybank/shared/base/base_entity.dart';

/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/// API CONTRACT ENTITIES
/// These define the shape of data the backend must provide.
/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class AccountEntity extends BaseEntity {
  final String id;
  final String accountNumber;
  final String holderName;
  final double balance;
  final String currency;
  final String? avatarUrl;

  const AccountEntity({
    required this.id,
    required this.accountNumber,
    required this.holderName,
    required this.balance,
    this.currency = 'IDR',
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, accountNumber, balance];
}

class QuickActionEntity extends BaseEntity {
  final String id;
  final String label;
  final String iconName; // Material icon name
  final String route;

  const QuickActionEntity({
    required this.id,
    required this.label,
    required this.iconName,
    required this.route,
  });

  @override
  List<Object?> get props => [id, label];
}

class ExclusiveServiceEntity extends BaseEntity {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final String? badge;

  const ExclusiveServiceEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    this.badge,
  });

  @override
  List<Object?> get props => [id, title];
}

class EWalletEntity extends BaseEntity {
  final String id;
  final String name;
  final double balance;
  final Color color;
  final String abbreviation;

  const EWalletEntity({
    required this.id,
    required this.name,
    required this.balance,
    required this.color,
    required this.abbreviation,
  });

  @override
  List<Object?> get props => [id, name, balance];
}

class PromoEntity extends BaseEntity {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String imageUrl;
  final Color overlayColor;

  const PromoEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.imageUrl,
    required this.overlayColor,
  });

  @override
  List<Object?> get props => [id, title];
}

class ProductEntity extends BaseEntity {
  final String id;
  final String title;
  final String category;
  final String imageUrl;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title];
}
