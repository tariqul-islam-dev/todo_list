import 'package:dartz/dartz.dart';
import 'package:todo_list/src/core/errors/failures.dart';
import 'package:todo_list/src/features/onboarding/domain/entities/onboarding.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, bool>> setIsFirstTime(Onboarding onboarding);

  Future<Either<Failure, Onboarding>> getIsFirstTime();
}
