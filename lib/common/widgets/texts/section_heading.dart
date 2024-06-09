import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.textColor,
    this.onPressed,
    required this.title,
    this.buttonTitle = 'View All',
    this.showActionButton = true,
    this.bigSize = false,
  });

  final Color? textColor;
  final bool showActionButton;
  final bool bigSize;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: bigSize
              ? Theme.of(context).textTheme.headlineMedium!.apply(fontWeightDelta: 2, color: textColor)
              : Theme.of(context).textTheme.headlineSmall!.apply(fontWeightDelta: 2, color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}
