import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/authentication/screens/on_boarding/onboarding.dart';

import 'common/cubit/theme_cubit.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (BuildContext context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeModeState>(
        builder: (BuildContext context, ThemeModeState state) {
          return GetMaterialApp(
            /// Localization is not available for the title.
            title: 'Outfit4rent',

            /// Theme stuff
            theme: TAppTheme.lightTheme,
            darkTheme: TAppTheme.darkTheme,
            themeMode: state.themeMode!,

            /// Localization stuff
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            home: const OnboardingScreen(),
          );
        },
      ),
    );
  }
}
