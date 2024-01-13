part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class GetIsFirstTimeEvent extends OnboardingEvent {
  @override
  List<Object?> get props => [];
}

class SetIsFirstTimeEvent extends OnboardingEvent {
  const SetIsFirstTimeEvent();

  @override
  List<Object?> get props => [];
}
