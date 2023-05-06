import 'package:authentication_repository/authentication_repository.dart';
import 'package:auto_route/annotations.dart';
import 'package:blueprint/app/routes/guards/authentication_guard.dart';
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
      create: (context) => SignInCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: _SignInView(
        onResult: onResult,
      ),
    );
  }
}

class _SignInView extends StatelessWidget {
  _SignInView({
    required this.onResult,
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationResultFunction onResult;

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.watch<SignInCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccessful) {
            onResult(true);
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
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Sign In'),
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  if (email.isNotEmpty && password.isNotEmpty) {
                    signInCubit.signInWithEmailAndPassword(email, password);
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
