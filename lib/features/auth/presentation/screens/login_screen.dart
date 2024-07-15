import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/utils/app_snackbar.dart';
import 'package:frontend/features/auth/presentation/widgets/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.showSignup});
  final VoidCallback showSignup;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthDone) {
            Navigator.pushReplacementNamed(context, '/tasks');
          } else if (state is AuthFailure) {
            AppSnack.error(context, state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _identifierController,
                decoration:
                    const InputDecoration(labelText: 'Username or Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 3.h),
              CustomButton(
                name: 'Sign In',
                onTap: () {
                  context.read<AuthBloc>().add(SignInEvent(
                        identifier: _identifierController.text,
                        password: _passwordController.text,
                      ));
                },
              ),
              SizedBox(height: 3.h),
              TextButton(
                onPressed: () {
                  widget.showSignup();
                },
                child: Text('New member? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
