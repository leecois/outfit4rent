import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';

class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key,
    required this.onTap,
    this.showActionButton = true,
  });

  final VoidCallback onTap;
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      onTap: onTap,
      leading: Obx(() {
        final networkImage = controller.user.value.picture;
        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
        return TCircularImage(
          image: image,
          isNetworkImage: networkImage.isNotEmpty,
          width: 50,
          height: 50,
          padding: 0,
        );
      }),
      title: Text(
        controller.user.value.name,
        style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      subtitle: Text(
        controller.user.value.email,
        style: Theme.of(context).textTheme.bodyMedium!.apply(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      trailing: showActionButton
          ? IconButton(
              onPressed: onTap,
              icon: Icon(
                Iconsax.user_edit_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
    );
  }
}
