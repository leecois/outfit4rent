import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/features/shop/models/cart_item_model.dart';
import 'package:outfit4rent/features/shop/models/package_model.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  final RxInt noOfCartItems = 0.obs;
  final RxDouble totalCartPrice = 0.0.obs;
  final RxInt productQuantityInCart = 0.obs;
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<CartItemModel?> selectedPackage = Rx<CartItemModel?>(null);
  final dark = THelperFunctions.isDarkMode(Get.context!);

  CartController() {
    loadCartItems();
  }

  // Add to cart for product
  void addToCart(ProductModel product) {
    if (selectedPackage.value == null) {
      TLoaders.warningSnackBar(title: 'Warning', message: 'Please select a package first');
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

  // Add to cart for package
  void addPackageToCart(PackageModel package) {
    // Remove any existing package in the cart
    selectedPackage.value = convertToCartItemFromPackage(package);

    // Update cart summary
    updateCart();
    TLoaders.customToast(message: 'Package Added to Cart');
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    String imageUrl = product.images.isNotEmpty ? product.images.first.url : '';
    return CartItemModel(
      packageId: '', // No package ID for individual products
      price: product.price,
      availableRentDays: 0, // Default or calculate as needed
      name: product.name,
      description: product.description,
      numOfProduct: 1, // Each product item is added individually
      createItems: [
        CreateItem(
          productId: product.id,
          name: product.name,
          size: product.size,
          deposit: product.deposit,
          price: product.price,
          quantity: quantity,
          imageUrl: imageUrl,
        )
      ],
    );
  }

  CartItemModel convertToCartItemFromPackage(PackageModel package) {
    return CartItemModel(
      packageId: package.id.toString(),
      price: package.price,
      availableRentDays: package.availableRentDays,
      name: package.name,
      description: package.description,
      numOfProduct: package.numOfProduct, // Set the package limit
      createItems: [], // Packages may have their own logic for items
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.createItems.fold(0, (sum, createItem) => sum + createItem.quantity);
      calculatedNoOfItems += item.createItems.fold(0, (sum, createItem) => sum + createItem.quantity);
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
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

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexOf(item);
    if (index != -1) {
      cartItems[index] = cartItems[index].copyWith(
        createItems: cartItems[index].createItems.map((createItem) {
          int currentTotalQuantity = getTotalProductQuantity() - createItem.quantity;
          int packageLimit = selectedPackage.value!.numOfProduct;
          if (currentTotalQuantity + createItem.quantity + 1 > packageLimit) {
            TLoaders.customToast(message: 'Package limit exceeded');
            return createItem;
          }
          if (createItem.productId == item.createItems.first.productId) {
            return createItem.copyWith(quantity: createItem.quantity + 1);
          }
          return createItem;
        }).toList(),
      );
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
        // Double-check the index before removing the item
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
      buttonColor: isDarkMode ? Colors.tealAccent : Colors.teal,
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
  }) {
    return CartItemModel(
      packageId: packageId ?? this.packageId,
      price: price ?? this.price,
      availableRentDays: availableRentDays ?? this.availableRentDays,
      name: name ?? this.name,
      description: description ?? this.description,
      numOfProduct: numOfProduct ?? this.numOfProduct,
      createItems: createItems ?? this.createItems,
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
  }) {
    return CreateItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      size: size ?? this.size,
      deposit: deposit ?? this.deposit,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
