import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wardrobe',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
