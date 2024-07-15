import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/widgets/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.showLogin});
  final VoidCallback showLogin;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthDone) {
            Navigator.pushReplacementNamed(context, '/task');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 3.h),
              CustomButton(
                name: 'Sign Up',
                onTap: () {
                  context.read<AuthBloc>().add(SignUpEvent(
                        username: _usernameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ));
                },
              ),
              SizedBox(height: 3.h),
              TextButton(
                onPressed: () {
                  widget.showLogin();
                },
                child: Text('Already a member? Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
