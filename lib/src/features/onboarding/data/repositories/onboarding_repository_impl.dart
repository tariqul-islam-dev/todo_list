import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/onboarding.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';
import '../models/onboarding_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Onboarding>> getIsFirstTime() async {
    try {
      final prefData = await localDataSource.getIsFirstTime();
      return right(prefData);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> setIsFirstTime(Onboarding onboarding) async {
    try {
      final prefData = await localDataSource.setIsFirstTime(
        OnboardingModel.fromObject(onboarding: onboarding),
      );
      return right(prefData);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    }
  }
}
