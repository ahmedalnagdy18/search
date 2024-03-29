class CartEntity {
  final int skip;
  final int limit;

  CartEntity([this.skip = 0, this.limit = 20]);

  toJson() {
    return {
      "skip": skip,
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
