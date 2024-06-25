import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  RxString selectedProductImage = ''.obs;
  RxList<String> productImages = <String>[].obs;

  void setProductImages(List<String> images) {
    productImages.assignAll(images);
    if (images.isNotEmpty) {
      selectedProductImage.value = images.first;
    }
  }

  List<String> getAllProductImages(ProductModel product) {
    List<String> images = product.images.map((image) => image.url).toList();
    images = _validateImageUrls(images);
    setProductImages(images);
    return images;
  }

  void showEnlargedImage(String image) {
    if (_isValidUrl(image)) {
      Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
          child: _buildEnlargedImageDialog(image),
        ),
      );
    } else {
      Get.snackbar('Error', 'Invalid image URL');
    }
  }

  void updateSelectedImage(String image) {
    selectedProductImage.value = image;
  }

  List<String> _validateImageUrls(List<String> urls) {
    return urls.where((url) => Uri.tryParse(url)?.hasAbsolutePath ?? false).toList();
  }

  bool _isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  Widget _buildEnlargedImageDialog(String image) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: TSizes.defaultSpace * 2,
                  horizontal: TSizes.defaultSpace,
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                  errorWidget: (context, url, error) => const Center(
                    child: CircularProgressIndicator(color: TColors.primary),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
