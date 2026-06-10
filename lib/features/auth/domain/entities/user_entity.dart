import 'package:d2ybank/shared/base/base_entity.dart';

class UserEntity extends BaseEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? avatarUrl;
  final String accountNumber;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl,
    required this.accountNumber,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [id, name, email, phone, accountNumber];
}