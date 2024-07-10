import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/favorites/favorite_repository.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';

class MyWardrobeController extends GetxController {
  static MyWardrobeController get instance => Get.find();

  final FavoriteRepository _favoriteRepository = Get.put(FavoriteRepository());
  final RxMap<int, bool> favorites = <int, bool>{}.obs;
  final RxList<ProductModel> favoriteProductsList = <ProductModel>[].obs;

  final int? customerId = TLocalStorage.instance().readData<int>('currentUser');

  @override
  void onInit() {
    super.onInit();
    if (customerId != null) {
      initFavorites();
      loadFavoriteProducts();
    }
  }

  Future<void> initFavorites() async {
    try {
      final favoriteProducts = await _favoriteRepository.getFavoriteProducts(customerId!);
      favorites.assignAll({for (var product in favoriteProducts) product.id: true});
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to initialize favorites: $e');
    }
  }

  Future<void> toggleFavoriteProduct(int productId) async {
    try {
      if (!favorites.containsKey(productId)) {
        await _favoriteRepository.addFavoriteProduct(customerId!, productId);
        favorites[productId] = true;
        await loadFavoriteProducts();
        TLoaders.customToast(message: 'Product added to Wishlist.');
      } else {
        await _favoriteRepository.removeFavoriteProduct(customerId!, productId);
        favorites.remove(productId);
        favoriteProductsList.removeWhere((product) => product.id == productId);
        TLoaders.customToast(message: 'Product removed from Wishlist.');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to toggle favorite: $e');
    }
  }

  bool isFavorite(int productId) => favorites[productId] ?? false;

  Future<void> loadFavoriteProducts() async {
    try {
      final products = await _favoriteRepository.getFavoriteProducts(customerId!);
      favoriteProductsList.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to load favorite products: $e');
    }
  }
}
