import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/bindings/general_bindings.dart';
import 'package:outfit4rent/common/widgets/first_screen/theme_card.dart';
import 'package:outfit4rent/routes/app_routes.dart';
import 'package:outfit4rent/utils/constants/colors.dart';

import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    return GetMaterialApp(
      darkTheme: TAppTheme.darkTheme,
      theme: TAppTheme.lightTheme,
      themeMode: themeController.themeMode.value,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const Scaffold(backgroundColor: TColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}
