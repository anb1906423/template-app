import 'package:get/get.dart';

class CartItem {
  final String productId;
  final String price;
  final String title;
  final String imageUrl;
  final RxInt _quantity;

  CartItem({
    required this.productId,
    required this.price,
    required int quantity,
    required this.title,
    required this.imageUrl,
  }) : _quantity = quantity.obs;

  int get quantity => _quantity.value;

  set quantity(int value) {
    _quantity.value = value;
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'title': title,
    };
  }
}

class Cart {
  final String userId;
  final List<CartItem> items;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String total;

  Cart({
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
    required this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>;
    final items = itemsList.map((item) => CartItem.fromJson(item)).toList();

    return Cart(
      userId: json['user_id'] as String,
      items: items,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      total: json['total'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'total': total,
    };
  }
}
