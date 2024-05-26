import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';

class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
      title: Text('Ackerman', style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
      subtitle: Text('Ackerman@gmail.com', style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
      trailing: IconButton(onPressed: onTap, icon: const Icon(Iconsax.user_edit_outline, color: TColors.white)),
    );
  }
}
