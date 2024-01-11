import 'package:app_ui/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BlueprintIcon extends StatelessWidget {
  const BlueprintIcon({
    super.key,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return switch (brightness) {
      Brightness.light => _LightIcon(
          key: key,
          height: height,
          width: width,
        ),
      Brightness.dark => _DarkIcon(
          key: key,
          height: height,
          width: width,
        ),
    };
  }
}

class _LightIcon extends StatelessWidget {
  const _LightIcon({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Assets.logo.iconLight.svg(
      height: height,
      width: width,
      package: 'app_ui',
    );
  }
}

class _DarkIcon extends StatelessWidget {
  const _DarkIcon({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Assets.logo.iconDark.svg(
      height: height,
      width: width,
      package: 'app_ui',
    );
  }
}
