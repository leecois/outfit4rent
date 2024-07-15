import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/products/product_repository.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final ProductRepository repository = Get.put(ProductRepository());
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    try {
      final productList = await repository.getAllProducts();
      assignProducts(productList);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Map<String, dynamic> query) async {
    try {
      final productList = await repository.fetchProductsByQuery(query);
      assignProducts(productList);
      return productList;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case "Higher Deposit":
        products.sort((a, b) => b.deposit.compareTo(a.deposit));
        break;
      case "Lower Deposit":
        products.sort((a, b) => a.deposit.compareTo(b.deposit));
        break;
      default:
        products.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts(selectedSortOption.value);
  }
}
