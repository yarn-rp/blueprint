import 'package:flutter/material.dart';

/// A widget that blocks user interaction with the rest of the screen.
class Barrier extends StatelessWidget {
  const Barrier({
    required this.onClose,
    required this.visible,
    super.key,
  });

  final VoidCallback onClose;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: kThemeAnimationDuration,
      curve: Curves.easeOut,
      tween: Tween(begin: 50, end: visible ? 200 : 50),
      builder: (context, __, _) => GestureDetector(
        onTap: onClose,
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
