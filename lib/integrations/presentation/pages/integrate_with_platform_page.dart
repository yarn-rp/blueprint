// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => sl<IntegrationsCubit>()
        ..integrateWithPlatform(
          platformId,
          {'code': code},
        ),
      child: const IntegrateWithPlatformView(),
    );
  }
}

/// {@template integrate_with_platform_view}
/// View for integrating with a platform.
/// {@endtemplate}
class IntegrateWithPlatformView extends StatelessWidget {
  /// {@macro integrate_with_platform_view}
  const IntegrateWithPlatformView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrate with Platform'),
      ),
      body: BlocBuilder<IntegrationsCubit, IntegrationsState>(
        builder: (context, state) {
          return state.maybeMap(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (state) => Center(
              child: Text('error state${state.message}'),
            ),
            integratedPlatform: (state) => Center(
              child: Column(
                children: [
                  Text('Integration with ${state.platformId} went successful. '
                      'You can now close this page.'),
                  ElevatedButton(
                    onPressed: () {
                      js.context.callMethod('close');
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
            orElse: () => Center(
              child: Text(state.toString()),
            ),
          );
        },
      ),
    );
  }
}
