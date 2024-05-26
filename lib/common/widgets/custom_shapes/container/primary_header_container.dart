import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:outfit4rent/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        child: Stack(
          children: [
            Positioned(top: -150, right: 0, child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(top: 100, right: 0, child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
