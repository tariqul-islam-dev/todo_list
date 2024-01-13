import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/src/core/usecase/usecase.dart';
import 'package:todo_list/src/features/onboarding/domain/entities/onboarding.dart';
import 'package:todo_list/src/features/onboarding/domain/usecases/set_is_first_time.dart';

import '../../domain/usecases/get_is_first_time.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SetIsFirstTime setIsFirstTime;
  final GetIsFirstTime getIsFirstTime;

  OnboardingBloc({
    required this.setIsFirstTime,
    required this.getIsFirstTime,
  }) : super(GetOnboardingState(onboarding: Onboarding())) {
    on<GetIsFirstTimeEvent>((event, emit) async {
      print(state.onboarding.isFirstTime);

      final prefData = await getIsFirstTime(NoParams());

      prefData.fold(
        (l) {},
        (r) {
          state.onboarding = r;
        },
      );

      if (state.onboarding.isFirstTime) {
        emit(NavigateToHomeState(onboarding: state.onboarding));
      }
    });

    on<SetIsFirstTimeEvent>((event, emit) async {
      Onboarding onboarding = Onboarding(isFirstTime: true);
      final prefData =
          await setIsFirstTime(OnBoardingParams(onboarding: onboarding));

      prefData.fold(
        (l) {},
        (r) {
          emit(NavigateToHomeState(onboarding: state.onboarding));
        },
      );

    });
  }
}
