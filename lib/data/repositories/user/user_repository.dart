import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfit4rent/data/repositories/authentication/authentication_repository.dart';
import 'package:outfit4rent/features/personalization/models/user_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/format_exception.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Todo: Function to save user to Firebase
  Future<void> saveUserRecord(UserModel user) async {
    try {
      final response = await THttpHelper.patch('customers/${user.id}', user.toJson());
      return response;
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  //Todo: Function to fetch user from Firebase
  Future<UserModel> fetchUserDetail(int userId) async {
    try {
      final response = await THttpHelper.get('customers/$userId');

      return UserModel.fromJson(response['data'] as Map<String, dynamic>);
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

  //Todo: Function to update user in Firebase
  Future<void> updateUserDetail(UserModel user) async {
    try {
      final response = await THttpHelper.put('customers/${user.id}', user.toJson());
      return response;
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  //Todo: Update any field in specific user document
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
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

  //Todo: Remove user from Firestore or restApi or any other database
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
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
