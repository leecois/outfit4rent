import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/products/product_repository.dart';
import 'package:outfit4rent/features/shop/models/product_detail_model.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final _productRepository = Get.put(ProductRepository());
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  Rx<ProductDetailModel?> productDetail = Rx<ProductDetailModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepository.getAllProduct();
      allProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Ops?', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //Todo: Get product by id
  Future<void> fetchProductDetail(int productId) async {
    try {
      isLoading.value = true;
      final detail = await _productRepository.getProductDetails(productId);
      productDetail.value = detail;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Ops?', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
