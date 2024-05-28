import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.primary : TColors.secondary,
        child: Stack(
          children: [
            Positioned(top: -150, right: -250, child: TCircularContainer(backgroundColor: dark ? TColors.textSecondary.withOpacity(0.1) : TColors.textPrimary.withOpacity(0.1))),
            Positioned(top: 100, right: -250, child: TCircularContainer(backgroundColor: dark ? TColors.textSecondary.withOpacity(0.1) : TColors.textPrimary.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
