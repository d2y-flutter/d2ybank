class PaginatedResponse<T> {
  final List<T> items;
  final PaginationMeta meta;
  const PaginatedResponse({required this.items, required this.meta});
  bool get hasNextPage => meta.currentPage < meta.lastPage;
  int get nextPage => meta.currentPage + 1;
}

class PaginationMeta {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  const PaginationMeta({required this.currentPage, required this.lastPage, required this.perPage, required this.total});
  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
    currentPage: json['current_page'] as int? ?? 1,
    lastPage: json['last_page'] as int? ?? 1,
    perPage: json['per_page'] as int? ?? 10,
    total: json['total'] as int? ?? 0,
  );
}
