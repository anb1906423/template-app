import '../config/api_config.dart';
class ProductModel {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  late final bool isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  static ProductModel fromJson(Map<String, dynamic> json) {
    String host = API().host;
    final imagePath = json['image'].replaceAll(r'\', '/').replaceFirst('public/', ''); // Thay đổi ký tự '\' thành '/'
    final imageUrl = '$host/$imagePath';

    return ProductModel(
      id: json['id'],
      title: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: imageUrl,
    );
  }
}