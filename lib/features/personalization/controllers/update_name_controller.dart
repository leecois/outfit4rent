import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/user/user_repository.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/personalization/screens/profile/profile_screen.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/helpers/network_manager.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final fullName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //Todo: Initialize names
  Future<void> initializeNames() async {
    fullName.text = userController.user.value.name;
  }

  Future<void> updateUserName() async {
    try {
      //Todo: Loading
      TFullScreenLoader.openLoadingDialog('Mô phật chờ chút để tôi update...', TImages.animation5);
      //Todo: Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //Todo: Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Update Full Name
      Map<String, dynamic> name = {'FullName': fullName.text.trim()};
      await userRepository.updateSingleField(name);

      //Todo: Update Rx value
      userController.user.value.name = fullName.text.trim();

      //Todo: Stop loading
      TFullScreenLoader.stopLoading();

      //Todo: Success screen
      TLoaders.successSnackBar(title: 'Yeah!', message: 'Your name has been updated successfully');

      //Todo: Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }
}
