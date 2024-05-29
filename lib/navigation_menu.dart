import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/features/personalization/screens/settings/setting_screen.dart';
import 'package:outfit4rent/features/shop/screens/home/home_screen.dart';
import 'package:outfit4rent/features/shop/screens/store/store_screen.dart';
import 'package:outfit4rent/features/shop/screens/wardrobe/wardobe_screen.dart';
import 'package:outfit4rent/features/shop/screens/wishlist/wishlist_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => SnakeNavigationBar.color(
          height: 50,
          backgroundColor: dark ? TColors.black : TColors.white,
          behaviour: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.circle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.all(TSizes.sm),
          snakeViewColor: dark ? TColors.white : TColors.black,
          selectedItemColor: dark ? TColors.dark : TColors.white,
          unselectedItemColor: dark ? TColors.white : TColors.black,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) => controller.selectedIndex.value = index,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                controller.selectedIndex.value == 0 ? (dark ? TImages.lightAppLogo : TImages.darkAppLogo) : (dark ? TImages.darkAppLogo : TImages.lightAppLogo),
                height: 34,
              ),
              label: 'O4R',
            ),
            const BottomNavigationBarItem(
              icon: Icon(MingCute.wardrobe_line),
              label: 'Wardrobe',
            ),
            const BottomNavigationBarItem(
              icon: Icon(MingCute.love_line),
              label: 'Wishlist',
            ),
            const BottomNavigationBarItem(
              icon: Icon(MingCute.camera_line),
              label: 'OOTD',
            ),
            const BottomNavigationBarItem(
              icon: Icon(MingCute.user_5_line),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const FavoriteScreen(),
    const WardrobeScreen(),
    const SettingScreen(),
  ];
}
