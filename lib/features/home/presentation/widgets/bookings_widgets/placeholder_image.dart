import 'package:flutter/material.dart';

/// Placeholder image widget for booking cards
///
/// Displays a gray container with an image icon when the booking image
/// fails to load or is not available.
class PlaceholderImage extends StatelessWidget {
  final double size;

  const PlaceholderImage({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey.shade200,
      child: Icon(
        Icons.image_outlined,
        size: size * 0.4,
        color: Colors.grey.shade400,
      ),
    );
  }
}
