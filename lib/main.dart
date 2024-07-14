import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/bootstrap.dart';
import 'package:frontend/features/task/presentation/bloc/task_bloc.dart';
import 'package:frontend/features/task/presentation/screens/task_screen.dart';
import 'package:frontend/injection_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  unawaited(bootstrap(() => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TaskBloc>()..add(LoadTasksEvent()),
        ),
      ],
      child: ResponsiveSizer(
        builder: (p0, p1, p2) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const TaskScreen(),
          );
        },
      ),
    );
  }
}
