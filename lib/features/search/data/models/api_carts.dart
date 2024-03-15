class Cart {
  int id;
  List<Product> products;

  Cart({
    required this.id,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      products: List<Product>.from(
        json['products'].map((productJson) => Product.fromJson(productJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  int id;
  String title;
  num price;
  int quantity;
  int total;
  num discountPercentage;
  num discountedPrice;
  String thumbnail;
  bool stutas = false;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      quantity: json['quantity'],
      total: json['total'],
      discountPercentage: json['discountPercentage'],
      discountedPrice: json['discountedPrice'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
      'total': total,
      'discountPercentage': discountPercentage,
      'discountedPrice': discountedPrice,
      'thumbnail': thumbnail,
    };
  }
}
