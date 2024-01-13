import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/onboarding.dart';
import '../repositories/onboarding_repository.dart';

class GetIsFirstTime implements UseCase<Onboarding, NoParams> {
  final OnboardingRepository onboardingRepository;

  GetIsFirstTime({required this.onboardingRepository});

  @override
  Future<Either<Failure, Onboarding>> call(NoParams params) {
    return onboardingRepository.getIsFirstTime();
  }
}
