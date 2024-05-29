import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    required this.mode,
    required this.icon,
  });

  final IconData icon;
  final ThemeMode mode;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final themeController = Get.put(ThemeController());

    return Obx(() {
      return Card(
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.shadow,
        color: themeController.themeMode.value == mode ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        child: InkWell(
          onTap: () => themeController.setTheme(mode),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Icon(
            icon,
            size: 32,
            color: themeController.themeMode.value != mode
                ? Theme.of(context).colorScheme.primary
                : dark
                    ? Colors.black
                    : Colors.white,
          ),
        ),
      );
    });
  }
}

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;

  void setTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }
}
