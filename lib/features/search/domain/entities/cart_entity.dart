class CartEntity {
  final int total;
  final int limit;

  CartEntity({required this.total, required this.limit});

  toJson() {
    return {
      "total": total,
      "limit": limit,
    };
  }
}

class PaginatedData<T> {
  final List<T> data;
  final PageInfo pageInfo;

  PaginatedData({required this.data, required this.pageInfo});
}

class PageInfo {
  final int totalPages;
  final int limit;

  PageInfo({
    required this.totalPages,
    required this.limit,
  });
}
