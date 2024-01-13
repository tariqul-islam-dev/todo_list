import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:todo_list/src/features/todo/presentation/bloc/todo_bloc.dart';

import '../../../di/injection_container.dart';
import '../../features/todo/presentation/pages/home/home_page.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        );

      case HomePage.routeName:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<TodoBloc>(
                  create: (context) => sl<TodoBloc>(),
                  child: const HomePage(),
                ));

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("No Route"),
            ),
          ),
        );
    }
  }
}
