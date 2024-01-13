import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/onboarding.dart';
import '../repositories/onboarding_repository.dart';

class SetIsFirstTime implements UseCase<bool, OnBoardingParams> {
  final OnboardingRepository onboardingRepository;

  SetIsFirstTime({required this.onboardingRepository});

  @override
  Future<Either<Failure, bool>> call(OnBoardingParams params) {
    return onboardingRepository.setIsFirstTime(params.onboarding);
  }
}

class OnBoardingParams extends Equatable {
  final Onboarding onboarding;

  const OnBoardingParams({required this.onboarding});

  @override
  List<Object?> get props => [onboarding];
}
