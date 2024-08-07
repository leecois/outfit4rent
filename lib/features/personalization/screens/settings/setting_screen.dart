import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:outfit4rent/common/widgets/first_screen/theme_card.dart';
import 'package:outfit4rent/common/widgets/list_title/setting_menu_title.dart';
import 'package:outfit4rent/common/widgets/list_title/user_profile_title.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/data/repositories/authentication/authentication_repository.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/personalization/screens/profile/my_wardrobe_screen.dart';
import 'package:outfit4rent/features/personalization/screens/profile/order_status_screen.dart';
import 'package:outfit4rent/features/personalization/screens/profile/profile_screen.dart';
import 'package:outfit4rent/features/personalization/screens/wallet/wallet_screen.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: Theme.of(context).colorScheme.primary))),
                  TUserProfileTitle(onTap: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  TSettingMenuTitle(
                      icon: Iconsax.ghost_outline, title: "My Wardrobe", subtitle: "Manage your rented and owned items", onTap: () => Get.to(() => const MyWardrobeScreen())),
                  Obx(
                    () => TSettingMenuTitle(
                      icon: Iconsax.wallet_3_outline,
                      title: "Wallet",
                      subtitle: "Balance: \$${controller.user.value.moneyInWallet ?? 0}",
                      onTap: () => Get.to(() => const UserWalletScreen()),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSectionHeading(title: 'My Orders', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingMenuTitle(
                      icon: Iconsax.close_circle_outline, title: "Canceled", subtitle: "View your canceled orders", onTap: () => Get.to(() => const OrderStatusScreen())),
                  TSettingMenuTitle(
                      icon: Iconsax.timer_1_outline, title: "Processing", subtitle: "Track your ongoing orders", onTap: () => Get.to(() => const OrderStatusScreen())),
                  TSettingMenuTitle(icon: Iconsax.receipt_text_outline, title: "Renting", subtitle: "View your renting", onTap: () => Get.to(() => const OrderStatusScreen())),
                  TSettingMenuTitle(icon: Iconsax.clock_outline, title: "Expired", subtitle: "View your expired rentals", onTap: () => Get.to(() => const OrderStatusScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingMenuTitle(icon: Iconsax.notification_outline, title: "Notifications", subtitle: "Manage your notification preferences", onTap: () {}),
                  TSettingMenuTitle(icon: Iconsax.security_outline, title: "Account Privacy", subtitle: "Manage your privacy settings", onTap: () {}),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.75 / 1,
                    padding: EdgeInsets.zero,
                    children: const <ThemeCard>[
                      ThemeCard(
                        mode: ThemeMode.system,
                        icon: FluentIcons.dark_theme_24_regular,
                      ),
                      ThemeCard(
                        mode: ThemeMode.light,
                        icon: FluentIcons.weather_sunny_24_regular,
                      ),
                      ThemeCard(
                        mode: ThemeMode.dark,
                        icon: FluentIcons.weather_moon_24_regular,
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => AuthenticationRepository.instance.signOut(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
