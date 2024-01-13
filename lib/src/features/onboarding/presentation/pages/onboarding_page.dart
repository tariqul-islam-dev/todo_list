import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:todo_list/src/features/todo/presentation/pages/home/home_page.dart';

class OnboardingPage extends StatelessWidget {
  static const routeName = "/onboarding";

  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OnboardingBloc>().add(GetIsFirstTimeEvent());

    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is NavigateToHomeState) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.routeName, (route) => false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: const Text("Skip"),
                    onPressed: () {
                      context.read<OnboardingBloc>().add(const SetIsFirstTimeEvent());
                    },
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Lottie.asset('assets/1.json'),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<OnboardingBloc>().add(const SetIsFirstTimeEvent());
          },
          child: const Icon(Icons.navigate_next_outlined),
        ),
      ),
    );
  }
}
