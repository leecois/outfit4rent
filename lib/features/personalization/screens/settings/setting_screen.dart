import 'package:easy_localization/easy_localization.dart';
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
import 'package:outfit4rent/features/personalization/screens/profile/profile_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Todo: Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //Todo: Appbar
                  TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))),

                  //Todo: User Profile Card
                  TUserProfileTitle(onTap: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  //Todo: Profile Card
                ],
              ),
            ),
            //Todo: Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Todo: Account Settings
                  const TSectionHeading(title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingMenuTitle(icon: Iconsax.safe_home_outline, title: "My Addresses", subtitle: "Manage your delivery addresses", onTap: () {}),
                  TSettingMenuTitle(icon: Iconsax.wallet_2_outline, title: "My Wallet", subtitle: "View your balance and transactions", onTap: () {}),
                  TSettingMenuTitle(icon: Iconsax.shopping_cart_outline, title: "My Orders", subtitle: "Track and manage your orders", onTap: () {}),
                  TSettingMenuTitle(icon: Iconsax.notification_bing_outline, title: "Notifications", subtitle: "Manage your notification preferences", onTap: () {}),
                  TSettingMenuTitle(icon: Iconsax.lock_1_outline, title: "Account Privacy", subtitle: "Manage your privacy settings", onTap: () {}),

                  // Todo: App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingMenuTitle(
                    icon: Iconsax.language_circle_bold,
                    title: "Language",
                    subtitle: "Change the app language",
                    trailing: Switch(
                      value: context.locale == const Locale('vi'),
                      onChanged: (bool newValue) {
                        context.setLocale(newValue ? const Locale('vi') : const Locale('en'));
                      },
                    ),
                  ),
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
                  //Todo: Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () {}, child: const Text('Logout')),
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
