import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/favorites/favorite_repository.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  // Variables
  final _favoriteRepository = Get.put(FavoriteRepository());
  final favorites = <int, bool>{}.obs;
  final customerId = TLocalStorage.instance().readData<int>('currentUser');

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  // Method to init favorites by fetching from API
  Future<void> initFavorites() async {
    final favoriteProducts = await _favoriteRepository.getFavoriteProducts(customerId!);
    for (var product in favoriteProducts) {
      favorites[product.id] = true;
    }
  }

  bool isFavorite(int productId) {
    return favorites[productId] ?? false;
  }

  Future<void> toggleFavoriteProduct(int productId) async {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      await _favoriteRepository.addFavoriteProduct(customerId!, productId);
      TLoaders.customToast(message: 'Product added to Wishlist.');
    } else {
      favorites.remove(productId);
      await _favoriteRepository.removeFavoriteProduct(customerId!, productId);
      favorites.refresh();
      TLoaders.customToast(message: 'Product removed from Wishlist.');
    }
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await _favoriteRepository.getFavoriteProducts(customerId!);
  }
}
