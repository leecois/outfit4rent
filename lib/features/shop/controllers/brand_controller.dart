import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/brands/brand_repository.dart';
import 'package:outfit4rent/features/shop/models/brand_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final _brandRepository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  // Load brand data
  Future<void> fetchBrands() async {
    try {
      // Show loading indicator
      isLoading.value = true;

      final brands = await _brandRepository.getAllBrands();
      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured == true).toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get category name by ID
  String getBrandNameById(int id) {
    final brand = allBrands.firstWhere((brand) => brand.id == id, orElse: () => BrandModel.empty());
    return brand.name;
  }
}
