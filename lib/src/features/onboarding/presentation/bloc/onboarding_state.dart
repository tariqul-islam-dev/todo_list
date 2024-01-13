part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  Onboarding onboarding;

  OnboardingState({required this.onboarding});
}

class GetOnboardingState extends OnboardingState {
  GetOnboardingState({required Onboarding onboarding})
      : super(onboarding: onboarding);

  @override
  List<Object> get props => [onboarding];
}

class NavigateToHomeState extends OnboardingState {
  NavigateToHomeState({required Onboarding onboarding})
      : super(onboarding: onboarding);

  @override
  List<Object> get props => [onboarding];
}
