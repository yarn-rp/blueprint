import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/app/routes/guards/authentication_guard.dart';
import 'package:blueprint/authentication/state_management/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:blueprint/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({
    required this.onResult,
    super.key,
  });

  final AuthenticationResultFunction onResult;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordCubit>(),
      child: _ForgotPasswordView(
        onResult: onResult,
      ),
    );
  }
}

class _ForgotPasswordView extends StatelessWidget {
  _ForgotPasswordView({required this.onResult});
  final AuthenticationResultFunction onResult;
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final forgotPasswordCubit = context.watch<ForgotPasswordCubit>();
    final size = MediaQuery.sizeOf(context);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state is PasswordResetState) {
                  onResult(result: true);
                } else if (state is ErrorResettingPasswordState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.failure.toString()),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.xlg),
                  width: size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.resetPasswordMessage),
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: l10n.email,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      FilledButton(
                        child: Text(l10n.sendEmail),
                        onPressed: () {
                          final email = _emailController.text;

                          if (email.isNotEmpty) {
                            forgotPasswordCubit.resetPassword(
                              email,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
