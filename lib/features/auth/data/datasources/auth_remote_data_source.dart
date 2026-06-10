import '../../domain/entities/user_entity.dart';

/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/// DUMMY DATA SOURCE
/// Replace this with real API calls when backend is ready.
/// The repository doesn't change — only swap this class.
/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class AuthRemoteDataSource {
  Future<UserEntity> login({required String password});
  Future<void> logout();
}

class AuthDummyDataSource implements AuthRemoteDataSource {
  static const _dummyPassword = '12345678';

  static const _dummyUser = UserEntity(
    id: 'usr_001',
    name: 'Rizky Adriansyah',
    email: 'rizky@d2ybank.com',
    phone: '+6281234567890',
    avatarUrl: 'https://i.pravatar.cc/300?u=rizky',
    accountNumber: '123-456-7890',
    isVerified: true,
  );

  @override
  Future<UserEntity> login({required String password}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (password != _dummyPassword) {
      throw Exception('Invalid credentials');
    }

    return _dummyUser;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}