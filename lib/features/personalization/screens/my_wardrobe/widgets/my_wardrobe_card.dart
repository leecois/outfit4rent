import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/common/widgets/texts/package_title_with_icon.dart';
import 'package:outfit4rent/features/shop/models/order_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/enums.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class MyWardrobeCard extends StatelessWidget {
  const MyWardrobeCard({
    super.key,
    this.onTap,
    required this.showBorder,
    required this.order,
  });

  final bool showBorder;
  final void Function()? onTap;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // Package Icons
            Flexible(
              child: TCircularImage(
                isNetworkImage: false,
                image: TImages.jeweleryIcon,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            // Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TPackageTitleWithIcon(
                    title: order.packageName,
                    packageTextSize: TextSizes.large,
                  ),
                  Text(
                    'From: ${DateFormat('dd/MM/yyyy').format(order.dateFrom)}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'To: ${DateFormat('dd/MM/yyyy').format(order.dateTo)}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'Status: ${_getStatusString(order.status)}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Confirmed';
      case 2:
        return 'In Progress';
      case 3:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
