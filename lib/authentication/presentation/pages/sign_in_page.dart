import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:blueprint/app/dependency_injection/init.dart';
import 'package:blueprint/app/routes/guards/authentication_guard.dart';
import 'package:blueprint/app/routes/routes.dart';
import 'package:blueprint/authentication/state_management/sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({
    required this.onResult,
    super.key,
  });

  final AuthenticationResultFunction onResult;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignInCubit>(),
      child: _SignInView(
        onResult: onResult,
      ),
    );
  }
}

class _SignInView extends StatefulWidget {
  const _SignInView({
    required this.onResult,
  });

  final AuthenticationResultFunction onResult;

  @override
  State<_SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<_SignInView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.watch<SignInCubit>();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<SignInCubit, SignInState>(
              listener: (context, state) {
                if (state is SignInSuccessful) {
                  widget.onResult(result: true);
                } else if (state is SignInError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.failure.toString()),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlueprintLogo(
                        width: size.width * 0.3,
                        height: size.height * 0.15,
                      ),
                      const SizedBox(height: AppSpacing.xxlg),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: _passwordController,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      FilledButton(
                        child: const Text('Sign In'),
                        onPressed: () {
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          if (email.isNotEmpty && password.isNotEmpty) {
                            signInCubit.signInWithEmailAndPassword(
                              email,
                              password,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: AppSpacing.xlg),
                      const Text("Don't have an account?"),
                      const SizedBox(height: AppSpacing.md),
                      TextButton(
                        child: const Text('Sign Up'),
                        onPressed: () => context.router.push(
                          SignUpRoute(onResult: widget.onResult),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextButton(
                        child: const Text('Forget Password'),
                        onPressed: () {},
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
