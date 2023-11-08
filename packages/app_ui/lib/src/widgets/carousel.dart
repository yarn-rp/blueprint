import 'package:app_ui/src/spacing/app_spacing.dart';
import 'package:flutter/widgets.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    required this.images,
    super.key,
    this.imageWidth = 120,
    this.imageHeight = 80,
    this.imageBorderRadius = 8,
  });

  final List<(ImageProvider<Object>, String, VoidCallback)> images;

  final double imageWidth;
  final double imageHeight;
  final double imageBorderRadius;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final (imageProvider, imageTitle, imageCallback) = images[index];

        return GestureDetector(
          onTap: imageCallback,
          child: SizedBox(
            width: imageWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(imageBorderRadius),
                  child: SizedBox(
                    width: imageWidth,
                    height: imageHeight,
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  imageTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          const SizedBox(width: AppSpacing.xs),
      itemCount: images.length,
    );
  }
}
