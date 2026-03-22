import '../../core/network/api_client.dart';

abstract class BaseRemoteDataSource {
  final ApiClient apiClient;
  const BaseRemoteDataSource({required this.apiClient});
}
