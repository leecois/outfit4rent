import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/categories/category_repository.dart';
import 'package:outfit4rent/features/shop/models/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loading indicator
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();
      // Update the categories list
      allCategories.assignAll(categories);

      // Filter featured categories (if needed)
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured == true).toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get category name by ID
  String getCategoryNameById(int id) {
    final category = allCategories.firstWhere((category) => category.id == id, orElse: () => CategoryModel.empty());
    return category.name;
  }
}
