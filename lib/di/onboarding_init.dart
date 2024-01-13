import 'package:shared_preferences/shared_preferences.dart';

import '../src/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import '../src/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../src/features/onboarding/domain/repositories/onboarding_repository.dart';
import '../src/features/onboarding/domain/usecases/get_is_first_time.dart';
import '../src/features/onboarding/domain/usecases/set_is_first_time.dart';
import '../src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'injection_container.dart';

Future<void> initOnboarding() async {
  // Bloc
  sl.registerFactory(
    () => OnboardingBloc(
      setIsFirstTime: sl(),
      getIsFirstTime: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SetIsFirstTime(onboardingRepository: sl(),),);
  sl.registerLazySingleton(() => GetIsFirstTime(onboardingRepository: sl(),),);

  // Repository
  sl.registerLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(localDataSource: sl(),),);

  // Data source
  sl.registerLazySingleton<OnboardingLocalDataSource>(() => OnboardingLocalDataSourceImpl(preferences: sl(),), );

  // External
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

}
