import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/products/product_repository.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final RxBool isLoading = false.obs;

  final ProductRepository productRepository = Get.put(ProductRepository());
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  Rx<ProductModel?> productDetail = Rx<ProductModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oops', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getAllProducts();
      allProducts.assignAll(products);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oops', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<ProductModel> fetchProductDetail(int productId) async {
    try {
      isLoading.value = true;
      final detail = await productRepository.getProductDetails(productId);
      productDetail.value = detail;
      return detail;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oops', message: e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
