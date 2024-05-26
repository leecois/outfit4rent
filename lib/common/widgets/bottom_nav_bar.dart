import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outfit4rent/common/cubit/bottom_nav_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 1, right: 4, left: 4),
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: BlocBuilder<BottomNavCubit, int>(builder: (BuildContext context, int state) {
        return BottomNavigationBar(
          currentIndex: state,
          onTap: (int index) => context.read<BottomNavCubit>().updateIndex(index),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).textTheme.bodySmall!.color,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(FluentIcons.animal_cat_24_regular),
              label: tr('bottom_nav_first'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(FluentIcons.building_shop_24_regular),
              label: tr('bottom_nav_second'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(FluentIcons.luggage_24_regular),
              label: tr('bottom_nav_third'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(FluentIcons.heart_24_regular),
              label: tr('bottom_nav_fourth'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(FluentIcons.person_24_regular),
              label: tr('bottom_nav_fifth'),
            ),
          ],
        );
      }),
    );
  }
}
