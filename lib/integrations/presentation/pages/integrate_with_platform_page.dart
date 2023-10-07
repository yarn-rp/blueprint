import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template integrate_with_platform_page}
/// A page that allows users to integrate with various platforms.
/// {@endtemplate}

@RoutePage()
class IntegrateWithPlatformPage extends StatelessWidget {
  /// {@macro integrate_with_platform_page}
  const IntegrateWithPlatformPage({
    @pathParam required this.platformId,
    @queryParam this.code,
    super.key,
  });

  final String platformId;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Integrating with with $platformId'),
      ),
      body: Center(
        child: Text('code: $code'),
      ),
    );
  }
}
