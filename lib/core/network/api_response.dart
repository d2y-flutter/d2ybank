class ApiResponse<T> {
  final bool status;
  final String message;
  final T? data;
  final Map<String, dynamic>? meta;

  const ApiResponse({required this.status, required this.message, this.data, this.meta});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponse<T>(
      status: json['status'] as bool? ?? true,
      message: json['message'] as String? ?? '',
      data: json['data'] != null && fromJsonT != null ? fromJsonT(json['data']) : json['data'] as T?,
      meta: json['meta'] as Map<String, dynamic>?,
    );
  }

  factory ApiResponse.fromJsonList(Map<String, dynamic> json, T Function(List<dynamic>) fromJsonList) {
    return ApiResponse<T>(
      status: json['status'] as bool? ?? true,
      message: json['message'] as String? ?? '',
      data: json['data'] != null ? fromJsonList(json['data'] as List<dynamic>) : null,
      meta: json['meta'] as Map<String, dynamic>?,
    );
  }
}
