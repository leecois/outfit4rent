import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/categories/category_repository.dart';
import 'package:outfit4rent/features/shop/models/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  //Todo: Load category data
  Future<void> fetchCategories() async {
    try {
      //Todo: Show loading indicator
      isLoading.value = true;

      //Todo: Fetch categories from data source (API, Database, etc)
      final categories = await _categoryRepository.getAllCategories();

      //Todo: Update the categories list
      allCategories.assignAll(categories);

      //Todo: Filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //Todo: Load selected category data

  //Todo: Get Category or Subcategory
}
