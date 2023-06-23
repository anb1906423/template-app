class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final bool isPaid;
  final String customerName;
  final String email;
  final String phoneNumber;
  final String address;
  final String deliveryCharges;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String total;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.isPaid,
    required this.customerName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.deliveryCharges,
    required this.createdAt,
    required this.updatedAt,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<OrderItem> orderItems = items
        .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
        .toList();

    return Order(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      items: orderItems,
      isPaid: json['isPaid'] as bool,
      customerName: json['customerName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      deliveryCharges: json['deliveryCharges'].toString(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      total: json['total'].toString(),
    );
  }
}

class OrderItem {
  final String productId;
  final String price;
  final String productName;
  final String tempValue;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.price,
    required this.quantity,
    required this.productName,
    required this.tempValue,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'] as String,
      quantity: json['quantity'] as int,
      price: json['price'].toString(),
      tempValue: json['tempValue'].toString(),
      productName: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'tempValue': tempValue,
      'productName': productName,
    };
  }
}
