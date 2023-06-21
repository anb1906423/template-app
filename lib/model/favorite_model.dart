
import '../config/api_config.dart';

class FavoriteModel {
  String name;
  String description;
  String category;
  String price;
  String image;
  int stock;
  bool state;
  String productId;

  FavoriteModel({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.image,
    required this.stock,
    required this.state,
    required this.productId,
  });

  FavoriteModel copyWith({
    String? name,
    String? description,
    String? category,
    String? price,
    String? image,
    int? stock,
    bool? state,
    String? productId,
  }) {
    return FavoriteModel(
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      image: image ?? this.image,
      stock: stock ?? this.stock,
      state: state ?? this.state,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'image': image,
      'stock': stock,
      'state': state,
      'productId': productId,
    };
  }

  factory  FavoriteModel.fromJson(Map<String, dynamic> json) {
    String host = API().host;
    final imagePath = json['image'].replaceAll(r'\', '/').replaceFirst('public/', ''); // Thay đổi ký tự '\' thành '/'
    final imageUrl = '$host/$imagePath';
    
    return  FavoriteModel(
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      image: imageUrl,
      stock: json['stock'],
      state: json['state'],
      productId: json['id'],
    );
  }
}
