import '../features/auth/data/datasources/local/auth_dao.dart';
import '../features/auth/data/datasources/local/auth_dao_impl.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/auth_use_cases.dart';
import '../features/auth/domain/usecases/check_is_first_launch_use_case.dart';
import '../features/auth/domain/usecases/set_is_first_launch_use_case.dart';
import '../features/auth/presentation/cubit/splash_cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../features/auth/presentation/cubit/splash_cubit/splash_cubit.dart';
import 'app_module.dart';

initAuthModule() {
//! Bloc && Cubit
//? ...SplashCubit
  ls.registerFactory<SplashCubit>(() => SplashCubit(useCases: ls()));
//? ...OnBoardingCubit
  ls.registerFactory<OnBoardingCubit>(() => OnBoardingCubit(useCases: ls()));

//! UseCases
//? ...provide all usecases with singltone pattern
  ls.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(
      checkIsFirstLaunchUseCase: CheckIsFirstLaunchUseCase(repository: ls()),
      setIsFirstLaunchUseCase: SetIsFirstLaunchUseCase(repository: ls()),
    ),
  );

//! Repository
//? ...AuthRepository
  ls.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDao: ls()),
  );

//! Datasources
//? ...local data source
  ls.registerLazySingleton<AuthDao>(
    () => AuthDaoImpl(prefs: ls()),
  );
}
