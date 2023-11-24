import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/routes/router/app_router.dart';
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart';

typedef AuthenticationResultFunction = void Function({
  bool? result,
});

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.authenticationCubit);

  final AuthenticationCubit authenticationCubit;

  final authenticationRoutesNames = [
    SignInRoute.name,
    SignUpRoute.name,
    ForgotPasswordRoute.name,
  ];

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (authenticationCubit.state is AuthenticatedState) {
      // if user is authenticated we continue
      resolver.next();
    } else {
      // we redirect the user to our login page
      await router.replace(
        SignInRoute(
          onResult: ({
            bool? result,
          }) {
            if (result == null) {
              return;
            }
            // if success == true the navigation will be resumed
            // else it will be aborted

            resolver.next(result);

            if (result) {
              // if the user is authenticated we remove all the authentication
              // routes from the navigation stack.
              router.removeWhere(
                (route) => authenticationRoutesNames.contains(route.name),
              );
            }
          },
        ),
      );
    }
  }
}
