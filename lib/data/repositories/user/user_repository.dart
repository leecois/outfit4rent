import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/personalization/models/user_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/format_exception.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Todo: Function to save user to Firebase
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
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

  //Todo: Function to fetch user from Firebase
  Future<UserModel> fetchUserRecord(String userId) async {
    try {
      final userDoc = await _db.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        return UserModel.fromSnapshot(userDoc);
      } else {
        throw 'User not found';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  //Todo: Function to update user in Firebase
  Future<void> updateUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).update(user.toJson());
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
