import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';

class OutfitOfTheDayScreen extends StatelessWidget {
  const OutfitOfTheDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Outfit of the day',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
