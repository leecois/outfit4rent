import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/products/product_repository.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final _productRepository = Get.put(ProductRepository());
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  Rx<ProductModel?> productDetail = Rx<ProductModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
    fetchAllFeaturedProducts();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Ops?', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final products = await _productRepository.getAllProducts();
      allProducts.assignAll(products);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Ops?', message: e.toString());
      return [];
    }
  }

  Future<void> fetchProductDetail(int productId) async {
    try {
      isLoading.value = true;
      final detail = await _productRepository.getProductDetails(productId);
      if (kDebugMode) {
        print(detail);
      }
      productDetail.value = detail;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Ops?', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
