import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/reviews/review_repository.dart';
import 'package:outfit4rent/features/shop/models/rating_reviews_model.dart';
import 'package:outfit4rent/features/shop/models/reviews_model.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/helpers/network_manager.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();

  final isLoading = false.obs;
  RxList<ReviewsModel> allReviews = <ReviewsModel>[].obs;
  Rx<RatingReviewsModel?> ratingReviews = Rx<RatingReviewsModel?>(null);
  Rx<ReviewsModel?> userReview = Rx<ReviewsModel?>(null);

  final localStorage = TLocalStorage.instance;
  final imageUploading = false.obs;

  final title = TextEditingController();
  final content = TextEditingController();
  final numberStars = 1.obs;
  final selectedImage = Rx<XFile?>(null);

  final _reviewsRepository = Get.put(ReviewRepository());
  final GlobalKey<FormState> reviewFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchReviewRecord();
  }

  @override
  void onClose() {
    // Dispose controllers to avoid memory leaks
    title.dispose();
    content.dispose();
    super.onClose();
  }

  Future<void> fetchReviewRecord() async {
    try {
      isLoading.value = true;
      final reviews = await _reviewsRepository.getAllReviews();
      allReviews.value = reviews;
    } catch (e) {
      allReviews.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRatingReviews(int packageId) async {
    try {
      isLoading.value = true;
      final rating = await _reviewsRepository.getRatingReviewsByPackageId(packageId);
      ratingReviews.value = rating;
    } catch (e) {
      ratingReviews.value = RatingReviewsModel(
        packageId: packageId,
        quantityOfReviews: 0,
        averageStar: 0.0,
        ratingStars: [
          RatingStar(starNumber: 1, quantity: 0, rate: 0.0),
          RatingStar(starNumber: 2, quantity: 0, rate: 0.0),
          RatingStar(starNumber: 3, quantity: 0, rate: 0.0),
          RatingStar(starNumber: 4, quantity: 0, rate: 0.0),
          RatingStar(starNumber: 5, quantity: 0, rate: 0.0),
        ],
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkUserReview(int packageId, int userId) async {
    try {
      isLoading.value = true;
      final reviews = await _reviewsRepository.getReviewsByPackageId(packageId);
      userReview.value = reviews.firstWhereOrNull((review) => review.customerId == userId);
    } catch (e) {
      userReview.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postReview(int packageId) async {
    final userId = localStorage.readData<int>('currentUser');

    try {
      isLoading.value = true;
      TFullScreenLoader.openLoadingDialog('Mô phật sắp xong rồi...', TImages.animation10);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!reviewFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final reviewData = {
        'content': content.text,
        'title': title.text,
        'numberStars': numberStars.value,
        'customerId': userId,
        'packageId': packageId,
        'reviewImages': <Map<String, String>>[]
      };

      if (selectedImage.value != null) {
        imageUploading.value = true;
        // Upload image
        final imageUrl = await _reviewsRepository.uploadImage('Review/Images', selectedImage.value!);
        (reviewData['reviewImages'] as List<Map<String, String>>).add({'url': imageUrl});
      }

      final review = await _reviewsRepository.postReview(reviewData);
      allReviews.add(review);

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Success screen
      TLoaders.successSnackBar(title: 'Yeah!', message: 'Review posted successfully');

      // Fetch the latest reviews and ratings
      await fetchReviewRecord();
      await fetchRatingReviews(packageId);

      // Move to previous screen
      Get.back(closeOverlays: true);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: 'Post review failed',
        message: 'An error occurred. Please try again later.',
      );
    } finally {
      isLoading.value = false;
      imageUploading.value = false;
    }
  }

  Future<void> deleteReview(int reviewId) async {
    try {
      await _reviewsRepository.deleteReview(reviewId);
      allReviews.removeWhere((review) => review.id == reviewId);
      userReview.value = null;
      TLoaders.successSnackBar(title: 'Deleted', message: 'Review deleted successfully');
      fetchReviewRecord();
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Delete review failed',
        message: 'An error occurred. Please try again later.',
      );
    }
  }
}
