import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/cubit/bottom_nav_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 1),
      elevation: 4,
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: BlocBuilder<BottomNavCubit, int>(builder: (BuildContext context, int state) {
        return BottomNavigationBar(
          currentIndex: state,
          onTap: (int index) => context.read<BottomNavCubit>().updateIndex(index),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).textTheme.bodySmall!.color,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(FluentIcons.animal_cat_24_regular),
              label: tr('bottom_nav_first'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(MingCute.wardrobe_line),
              label: tr('bottom_nav_second'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(MingCute.love_line),
              label: tr('bottom_nav_third'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(MingCute.camera_line),
              label: tr('bottom_nav_fourth'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(MingCute.user_5_line),
              label: tr('bottom_nav_fifth'),
            ),
          ],
        );
      }),
    );
  }
}
