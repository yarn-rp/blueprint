import 'package:authentication_repository/authentication_repository.dart';
import 'package:auto_route/annotations.dart';
import 'package:blueprint/app/routes/guards/authentication_guard.dart';
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({
    required this.onResult,
    super.key,
  });

  final AuthenticationResultFunction onResult;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: _SignUpView(
        onResult: onResult,
      ),
    );
  }
}

class _SignUpView extends StatelessWidget {
  _SignUpView({
    required this.onResult,
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final AuthenticationResultFunction onResult;

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.watch<SignUpCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessful) {
            onResult(true);
          } else if (state is SignUpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.toString()),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextField(
                controller: _repeatPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Repeat Password',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Sign In'),
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final repeatPassword = _repeatPasswordController.text;
                  if (password != repeatPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Passwords do not match'),
                      ),
                    );
                    return;
                  }

                  if (email.isNotEmpty && password.isNotEmpty) {
                    signInCubit.signUpWithEmailAndPassword(email, password);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
