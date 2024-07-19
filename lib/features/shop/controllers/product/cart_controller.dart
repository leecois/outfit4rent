import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/features/shop/models/cart_item_model.dart';
import 'package:outfit4rent/features/shop/models/category_package_model.dart';
import 'package:outfit4rent/features/shop/models/package_model.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/features/shop/screens/package/package_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  final RxInt noOfCartItems = 0.obs;
  final RxDouble totalCartPrice = 0.0.obs;
  final RxDouble totalProductDeposit = 0.0.obs;
  final RxDouble totalPackagePrice = 0.0.obs;
  final RxInt productQuantityInCart = 0.obs;
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<CartItemModel?> selectedPackage = Rx<CartItemModel?>(null);
  final RxMap<int, int> categoryLimits = <int, int>{}.obs;
  final localStorage = TLocalStorage.instance;

  CartController() {
    loadCartItems();
  }

  // Add to cart for product
  void addToCart(ProductModel product) {
    if (selectedPackage.value == null) {
      TLoaders.navigateSnackBar(
        title: 'Package Required',
        message: 'Please select a package before adding products to your cart.',
        buttonText: 'Select Package',
        onButtonPressed: () {
          Get.to(() => const PackageScreen());
        },
      );
      return;
    }

    // Quantity check
    if (productQuantityInCart.value < 1) {
      TLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // Out of stock check
    if (product.quantity < 1) {
      TLoaders.warningSnackBar(title: 'Warning', message: 'Product Out of Stock');
      return;
    }

    // Check category limit
    CategoryPackageModel? categoryPackage =
        selectedPackage.value?.categoryPackages.firstWhere((cp) => cp.categoryId == product.idCategory, orElse: () => CategoryPackageModel.empty());

    if (categoryPackage != null) {
      int currentCategoryQuantity = getCurrentCategoryQuantity(product.idCategory, excludeProductId: product.id);

      int newTotalQuantity = currentCategoryQuantity + productQuantityInCart.value;

      if (newTotalQuantity > categoryPackage.maxAvailableQuantity) {
        TLoaders.warningSnackBar(
          title: 'Category Limit Exceeded',
          message: 'You can only add up to ${categoryPackage.maxAvailableQuantity} items from the ${categoryPackage.category.name} category.',
        );
        return;
      }
    }

    // Check if adding the product exceeds the package limit
    int currentTotalQuantity = getTotalProductQuantity() - getProductQuantityInCart(product.id.toString());
    int packageLimit = selectedPackage.value!.numOfProduct;
    if (currentTotalQuantity + productQuantityInCart.value > packageLimit) {
      TLoaders.customToast(message: 'Package limit exceeded');
      return;
    }

    // Check if the product is already in the cart
    int index = cartItems.indexWhere((cartItem) => cartItem.createItems.any((item) => item.productId == product.id));

    if (index == -1) {
      // If the product is not in the cart, add it
      cartItems.add(convertToCartItem(product, productQuantityInCart.value));
    } else {
      // If the product is already in the cart, update the quantity
      cartItems[index] = cartItems[index].copyWith(
        createItems: cartItems[index].createItems.map((item) {
          if (item.productId == product.id) {
            return item.copyWith(quantity: productQuantityInCart.value);
          }
          return item;
        }).toList(),
      );
    }

    // Update cart summary
    updateCart();
    TLoaders.customToast(message: 'Product Added to Cart');
  }

  int getCurrentCategoryQuantity(int categoryId, {int? excludeProductId, int excludeQuantity = 0}) {
    return cartItems.fold(0, (sum, item) {
      return sum +
          item.createItems.where((createItem) {
            if (createItem.idCategory == categoryId) {
              if (excludeProductId != null && createItem.productId == excludeProductId) {
                return false; // Exclude this product from the count
              }
              return true;
            }
            return false;
          }).fold(0, (itemSum, createItem) => itemSum + createItem.quantity);
    });
  }

  bool isNewPackage(PackageModel package) {
    return selectedPackage.value == null || selectedPackage.value!.packageId != package.id.toString();
  }

  // Add to cart for package
  void addPackageToCart(PackageModel package) {
    final isDarkMode = THelperFunctions.isDarkMode(Get.context!);
    if (isNewPackage(package)) {
      Get.defaultDialog(
        title: 'Change Package',
        middleText: 'Changing the package will remove all products from your cart. Do you want to continue?',
        textConfirm: 'Yes',
        textCancel: 'No',
        confirmTextColor: isDarkMode ? Colors.black : Colors.white,
        cancelTextColor: isDarkMode ? Colors.white : Colors.black,
        buttonColor: isDarkMode ? TColors.white : TColors.primary,
        onConfirm: () {
          _addNewPackage(package);
          Get.back();
        },
      );
    } else {
      _addNewPackage(package);
    }
  }

  void _addNewPackage(PackageModel package) {
    clearAllProducts();
    cartItems.removeWhere((item) => item.packageId.isNotEmpty);
    selectedPackage.value = convertToCartItemFromPackage(package);
    cartItems.add(selectedPackage.value!);
    productQuantityInCart.value = 0;
    updateCart();
    TLoaders.customToast(message: 'Package Added to Cart');
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    String imageUrl = product.images.isNotEmpty ? product.images.first.url : '';
    return CartItemModel(
      packageId: selectedPackage.value?.packageId ?? '', // Use the selected package ID
      price: selectedPackage.value?.price ?? 0, // Use the selected package price
      availableRentDays: selectedPackage.value?.availableRentDays ?? 0,
      name: product.name,
      description: product.description,
      numOfProduct: selectedPackage.value?.numOfProduct ?? 1,
      createItems: [
        CreateItem(
          productId: product.id,
          name: product.name,
          size: product.size,
          deposit: product.deposit,
          price: product.price,
          quantity: quantity,
          imageUrl: imageUrl,
          idCategory: product.idCategory,
        )
      ],
      categoryPackages: selectedPackage.value?.categoryPackages ?? [],
    );
  }

  CartItemModel convertToCartItemFromPackage(PackageModel package) {
    return CartItemModel(
      packageId: package.id.toString(),
      price: package.price,
      availableRentDays: package.availableRentDays,
      name: package.name,
      description: package.description,
      numOfProduct: package.numOfProduct,
      createItems: [],
      categoryPackages: package.categoryPackages ?? [],
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalDeposit = 0.0;
    double calculatedPackagePrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      // Calculate total deposit for products
      calculatedTotalDeposit += item.createItems.fold(0.0, (sum, createItem) => sum + (createItem.deposit! * createItem.quantity * calculatedPackagePrice));

      // Use the package price associated with each item
      calculatedPackagePrice = item.price.toDouble();

      calculatedNoOfItems += item.createItems.fold(0, (sum, createItem) => sum + createItem.quantity);
    }

    // Calculate total cart price
    totalCartPrice.value = calculatedTotalDeposit + calculatedPackagePrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    localStorage.saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = localStorage.readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings.map((item) {
        try {
          return CartItemModel.fromJson(item as Map<String, dynamic>);
        } catch (e) {
          TLoaders.customToast(message: 'Error loading cart items');
          return CartItemModel.empty();
        }
      }));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    return cartItems.fold(0, (sum, item) {
      return sum +
          item.createItems.fold(0, (innerSum, createItem) {
            return innerSum + (createItem.productId.toString() == productId ? createItem.quantity : 0);
          });
    });
  }

  int getTotalProductQuantity() {
    return cartItems.fold(0, (sum, item) => sum + item.createItems.fold(0, (innerSum, createItem) => innerSum + createItem.quantity));
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    selectedPackage.value = null;
    updateCart();
  }

  void clearAllProducts() {
    cartItems.removeWhere((item) => item.packageId.isEmpty);
    updateCart();
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexOf(item);
    if (index != -1 && item.createItems.isNotEmpty) {
      CartItemModel updatedItem = cartItems[index].copyWith(
        createItems: cartItems[index].createItems.map((createItem) {
          if (createItem.productId == item.createItems.first.productId) {
            // Check category limit
            CategoryPackageModel? categoryPackage =
                selectedPackage.value?.categoryPackages.firstWhere((cp) => cp.categoryId == createItem.idCategory, orElse: () => CategoryPackageModel.empty());

            if (categoryPackage != null) {
              int currentCategoryQuantity = getCurrentCategoryQuantity(createItem.idCategory, excludeProductId: createItem.productId);
              int newTotalQuantity = currentCategoryQuantity + createItem.quantity + 1;

              if (newTotalQuantity > categoryPackage.maxAvailableQuantity) {
                TLoaders.warningSnackBar(
                  title: 'Category Limit Exceeded',
                  message: 'You can only add up to ${categoryPackage.maxAvailableQuantity} items from this category.',
                );
                return createItem;
              }
            }

            // Check package limit
            int currentTotalQuantity = getTotalProductQuantity();
            int packageLimit = selectedPackage.value!.numOfProduct;
            if (currentTotalQuantity + 1 > packageLimit) {
              TLoaders.customToast(message: 'Package limit exceeded');
              return createItem;
            }

            return createItem.copyWith(quantity: createItem.quantity + 1);
          }
          return createItem;
        }).toList(),
      );

      cartItems[index] = updatedItem;
      updateCart();
    }
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexOf(item);
    if (index != -1) {
      if (cartItems[index].createItems.first.quantity > 1) {
        cartItems[index] = cartItems[index].copyWith(
          createItems: cartItems[index].createItems.map((createItem) {
            if (createItem.productId == item.createItems.first.productId) {
              return createItem.copyWith(quantity: createItem.quantity - 1);
            }
            return createItem;
          }).toList(),
        );
        updateCart();
      } else {
        removeFromCartDialog(index, item);
      }
    }
  }

  void removeFromCartDialog(int index, CartItemModel item) {
    final isDarkMode = THelperFunctions.isDarkMode(Get.context!);

    Get.defaultDialog(
      title: 'Remove Product',
      titleStyle: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      middleText: 'Are you sure you want to remove this item from the cart?',
      middleTextStyle: TextStyle(
        color: isDarkMode ? Colors.white70 : Colors.black87,
      ),
      backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
      onConfirm: () {
        if (index >= 0 && index < cartItems.length) {
          cartItems[index] = cartItems[index].copyWith(
            createItems: cartItems[index].createItems.where((createItem) => createItem.productId != item.createItems.first.productId).toList(),
          );
          if (cartItems[index].createItems.isEmpty) {
            cartItems.removeAt(index);
          }
          updateCart();
          TLoaders.customToast(message: 'Product Removed from Cart');
        }
        Get.back();
      },
      onCancel: () {},
      confirmTextColor: isDarkMode ? Colors.black : Colors.white,
      cancelTextColor: isDarkMode ? Colors.white : Colors.black,
      buttonColor: isDarkMode ? TColors.white : TColors.primary,
      textConfirm: 'Remove',
      textCancel: 'Cancel',
      radius: 10,
    );
  }

  // Initialize already added items count in cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    int index = cartItems.indexWhere((cartItem) => cartItem.createItems.any((item) => item.productId == product.id));
    if (index != -1) {
      final existingProduct = cartItems[index].createItems.firstWhere((item) => item.productId == product.id);
      productQuantityInCart.value = existingProduct.quantity;
    } else {
      productQuantityInCart.value = 0;
    }
  }
}

extension CartItemModelCopyWith on CartItemModel {
  CartItemModel copyWith({
    String? packageId,
    int? price,
    int? availableRentDays,
    String? name,
    String? description,
    int? numOfProduct,
    List<CreateItem>? createItems,
    List<CategoryPackageModel>? categoryPackages,
  }) {
    return CartItemModel(
      packageId: packageId ?? this.packageId,
      price: price ?? this.price,
      availableRentDays: availableRentDays ?? this.availableRentDays,
      name: name ?? this.name,
      description: description ?? this.description,
      numOfProduct: numOfProduct ?? this.numOfProduct,
      createItems: createItems ?? this.createItems,
      categoryPackages: categoryPackages ?? this.categoryPackages,
    );
  }
}

extension CreateItemCopyWith on CreateItem {
  CreateItem copyWith({
    int? productId,
    String? name,
    String? size,
    double? deposit,
    int? price,
    int? quantity,
    String? imageUrl,
    int? idCategory,
  }) {
    return CreateItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      size: size ?? this.size,
      deposit: deposit ?? this.deposit,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      idCategory: idCategory ?? this.idCategory,
    );
  }
}
