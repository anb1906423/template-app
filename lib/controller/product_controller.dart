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
}
