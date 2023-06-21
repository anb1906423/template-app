import 'package:dartz/dartz.dart' as dartz;
import 'package:get/get.dart';

import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      final productService = Get.find<ProductService>();
      final productList = await productService.fetchProducts();
      final productModels = productList
          .map((product) => ProductModel(
                id: product.id,
                title: product.title,
                description: product.description,
                price: product.price,
                imageUrl: product.imageUrl,
                isFavorite: product.isFavorite,
              ))
          .toList();
      products.assignAll(productModels);
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  ProductModel? getProductById(String id) {
    return products.firstWhereOrNull((product) => product.id == id);
  }

  RxList<ProductModel> filteredProducts = RxList<ProductModel>();

  void searchProduct(dartz.Option<String> keywordOption) {
    final keyword = keywordOption.getOrElse(() => '').toLowerCase();

    if (keyword.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(products.where((product) {
        final productName = product.title.toLowerCase();
        final removedDiacriticsKeyword =
            removeDiacriticMarks(keyword).toLowerCase();

        return productName.contains(keyword) ||
            removeDiacriticMarks(productName)
                .contains(removedDiacriticsKeyword);
      }).toList());
    }

    update();
  }

  String removeDiacriticMarks(String text) {
    return text
        .replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a')
        .replaceAll(RegExp('[èéẹẻẽêềếệểễ]'), 'e')
        .replaceAll(RegExp('[ìíịỉĩ]'), 'i')
        .replaceAll(RegExp('[òóọỏõôồốộổỗơờớợởỡ]'), 'o')
        .replaceAll(RegExp('[ùúụủũưừứựửữ]'), 'u')
        .replaceAll(RegExp('[ỳýỵỷỹ]'), 'y')
        .replaceAll(RegExp('[đ]'), 'd');
  }
}
