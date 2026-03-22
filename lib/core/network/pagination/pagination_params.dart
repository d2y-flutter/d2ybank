class PaginationParams {
  final int page;
  final int limit;
  final String? search;
  const PaginationParams({this.page = 1, this.limit = 10, this.search});
  Map<String, dynamic> toQueryParams() => {
    'page': page, 'limit': limit,
    if (search != null && search!.isNotEmpty) 'search': search,
  };
  PaginationParams nextPage() => PaginationParams(page: page + 1, limit: limit, search: search);
}
