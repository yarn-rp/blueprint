import 'package:app_ui/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BlueprintLogo extends StatelessWidget {
  const BlueprintLogo({
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
      Brightness.light => _LightLogo(
          key: key,
          height: height,
          width: width,
        ),
      Brightness.dark => _DarkLogo(
          key: key,
          height: height,
          width: width,
        ),
    };
  }
}

class _LightLogo extends StatelessWidget {
  const _LightLogo({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Assets.logo.logoLight.svg(
      height: height,
      width: width,
      package: 'app_ui',
    );
  }
}

class _DarkLogo extends StatelessWidget {
  const _DarkLogo({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Assets.logo.logoDark.svg(
      height: height,
      width: width,
      package: 'app_ui',
    );
  }
}
