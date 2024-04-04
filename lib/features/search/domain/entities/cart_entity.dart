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
