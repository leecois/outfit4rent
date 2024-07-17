import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfit4rent/features/shop/models/rating_reviews_model.dart';
import 'package:outfit4rent/features/shop/models/reviews_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/format_exception.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class ReviewRepository extends GetxController {
  static ReviewRepository get instance => Get.find();

  // Get all reviews
  Future<List<ReviewsModel>> getAllReviews() async {
    try {
      final response = await THttpHelper.get('reviews');

      if (response.containsKey('data')) {
        final List<dynamic> data = response['data'] as List<dynamic>;
        return data.map((json) => ReviewsModel.fromJson(json)).toList();
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  // Get reviews by package id
  Future<List<ReviewsModel>> getReviewsByPackageId(int packageId) async {
    try {
      final response = await THttpHelper.get('reviews/packages/$packageId');

      if (response.containsKey('data')) {
        final List<dynamic> data = response['data'] as List<dynamic>;
        return data.map((json) => ReviewsModel.fromJson(json)).toList();
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  Future<RatingReviewsModel> getRatingReviewsByPackageId(int packageId) async {
    try {
      final response = await THttpHelper.get('reviews/packages/$packageId/ratings');

      if (response.containsKey('data')) {
        return RatingReviewsModel.fromJson(response['data']);
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  // Post a review
  Future<ReviewsModel> postReview(Map<String, dynamic> reviewData) async {
    try {
      final response = await THttpHelper.post('reviews', reviewData);

      if (response.containsKey('data')) {
        return ReviewsModel.fromJson(response['data']);
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  // Patch a review
  Future<ReviewsModel> patchReview(int reviewId, Map<String, dynamic> reviewData) async {
    try {
      final response = await THttpHelper.patch('reviews/$reviewId', reviewData);

      if (response.containsKey('data')) {
        return ReviewsModel.fromJson(response['data']);
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  // Delete a review
  Future<void> deleteReview(int reviewId) async {
    try {
      await THttpHelper.delete('reviews/$reviewId');
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  // Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }
}
