import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/di/injection_container.dart';
import 'package:todo_list/src/core/route/route_generator.dart';
import 'package:todo_list/src/features/onboarding/presentation/pages/onboarding_page.dart';

import 'firebase_options.dart';
import 'src/features/onboarding/presentation/bloc/onboarding_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await init();

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<OnboardingBloc>(
      create: (context) => sl<OnboardingBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: OnboardingPage.routeName,
      ),
    );

  }
}
