import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfit4rent/features/personalization/models/user_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/format_exception.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // Save device token
  Future<void> saveDeviceToken(int customerId, String token) async {
    try {
      await THttpHelper.post(
        'device-token',
        {
          'key': customerId,
          'deviceToken': token,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed to save device token: $e');
      }
    }
  }

  // Todo: Function to save user to Firebase
  Future<void> updateUserDetail(UserModel user) async {
    try {
      final response = await THttpHelper.patch('customers/${user.id}', user.toJson());
      return response;
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  //Todo: Update Single Field Picture
  // Update single field
  Future<void> updateUserPicture(int userId, String pictureUrl) async {
    try {
      await THttpHelper.patch(
        'customers/$userId',
        {
          'picture': pictureUrl,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update user picture: $e');
      }
    }
  }

  //Todo: Function to fetch user from Firebase
  Future<UserModel> fetchUserDetail(int userId) async {
    try {
      final response = await THttpHelper.get('customers/$userId');
      return UserModel.fromJson(response['data'] as Map<String, dynamic>);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  //Todo: Update Single Field Name
  Future<void> updateUserName(int userId, String name) async {
    try {
      await THttpHelper.patch(
        'customers/$userId',
        {
          'name': name,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update user name: $e');
      }
    }
  }

  //Todo: Upload any Image
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
