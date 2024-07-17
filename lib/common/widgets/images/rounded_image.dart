import 'package:flutter/material.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.onPressed,
    this.border,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.isNetworkImage = false,
    this.borderRadius = TSizes.md,
    this.onDelete,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final VoidCallback? onDelete; // Add callback for delete action

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              border: border,
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: ClipRRect(
              borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
              child: isNetworkImage
                  ? Image.network(
                      imageUrl,
                      fit: fit,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          TImages.lightAppLogo,
                          fit: fit,
                        );
                      },
                    )
                  : Image.asset(
                      imageUrl,
                      fit: fit,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          TImages.lightAppLogo,
                          fit: fit,
                        );
                      },
                    ),
            ),
          ),
        ),
        if (onDelete != null)
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onDelete,
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
