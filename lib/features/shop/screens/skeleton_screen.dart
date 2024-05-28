import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit4rent/features/personalization/screens/settings/setting_screen.dart';
import 'package:outfit4rent/features/shop/screens/store/store_screen.dart';
import 'package:outfit4rent/features/shop/screens/wardrobe/wardobe_screen.dart';
import 'package:outfit4rent/features/shop/screens/wishlist/wishlist_screen.dart';

import '../../../common/cubit/bottom_nav_cubit.dart';
import '../../../common/widgets/bottom_nav_bar.dart';
import 'home/home_screen.dart';

class SkeletonScreen extends StatefulWidget {
  const SkeletonScreen({super.key});

  @override
  State<SkeletonScreen> createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  @override
  Widget build(BuildContext context) {
    const List<Widget> pageNavigation = <Widget>[
      HomeScreen(),
      StoreScreen(),
      FavoriteScreen(),
      WardrobeScreen(),
      SettingScreen(),
    ];

    return BlocProvider<BottomNavCubit>(
        create: (BuildContext context) => BottomNavCubit(),
        child: Scaffold(
          extendBodyBehindAppBar: true,

          /// When switching between tabs this will fade the old
          /// layout out and the new layout in.
          body: BlocBuilder<BottomNavCubit, int>(
            builder: (BuildContext context, int state) {
              return AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: pageNavigation.elementAt(state));
            },
          ),

          bottomNavigationBar: const BottomNavBar(),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ));
  }
}
