import 'package:dartz/dartz.dart' as dartz;
import 'package:get/get.dart';

import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductController extends GetxController {
final RxList<ProductModel> products = <ProductModel>[].obs;
final RxInt currentPage = 1.obs; // Trang hiện tại
final RxInt totalPages = 1.obs; // Tổng số trang
final int itemsPerPage = 6; // Số sản phẩm trên mỗi trang

@override
void onInit() {
  super.onInit();
  fetchProducts();
}

void goToPage(int page) {
  if (page >= 1 && page <= totalPages.value) {
    currentPage.value = page;
    // Gọi hàm để tải dữ liệu cho trang mới
    fetchProducts();
  }
}
void fetchProducts() async {
  try {
    final productService = Get.find<ProductService>();
    final productList = await productService.fetchProducts();

    products.clear();
    products.addAll(productList.map((product) => ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    )));

    // Tính toán tổng số trang dựa trên số lượng sản phẩm và số sản phẩm trên mỗi trang
    totalPages.value = (products.length / itemsPerPage).ceil();
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
