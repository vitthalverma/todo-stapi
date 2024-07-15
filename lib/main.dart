import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bootstrap.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:frontend/features/auth/presentation/screens/auth_screen.dart';
import 'package:frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:frontend/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:frontend/features/task/presentation/bloc/task_bloc.dart';
import 'package:frontend/features/task/presentation/screens/task_screen.dart';
import 'package:frontend/injection_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  unawaited(bootstrap(() => const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String?> _getTokenFuture;

  @override
  void initState() {
    super.initState();
    _getTokenFuture = _getToken();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        } else {
          final isLoggedIn = snapshot.hasData && snapshot.data != null;

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => sl<TaskBloc>()..add(LoadTasksEvent())),
              BlocProvider(create: (context) => sl<AuthBloc>()),
            ],
            child: ResponsiveSizer(
              builder: (p0, p1, p2) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple,
                    ),
                    useMaterial3: true,
                  ),
                  initialRoute: isLoggedIn ? '/tasks' : '/',
                  routes: {
                    '/': (context) => const AuthScreen(),
                    //      '/ls': (context) => const LoginScreen(),

                    '/tasks': (context) => const TaskScreen(),
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
