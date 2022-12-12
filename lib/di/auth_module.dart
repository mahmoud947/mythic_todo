import 'package:mythic_todo/features/auth/data/datasources/remote/social_authenticator.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/social_authenticator_with_firebase.dart';
import 'package:mythic_todo/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:mythic_todo/features/auth/presentation/bloc/register/register_bloc.dart';

import '../features/auth/data/datasources/local/auth_dao.dart';
import '../features/auth/data/datasources/local/auth_dao_impl.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/auth_use_cases.dart';
import '../features/auth/domain/usecases/check_is_first_launch_use_case.dart';
import '../features/auth/domain/usecases/set_is_first_launch_use_case.dart';
import '../features/auth/presentation/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../features/auth/presentation/cubit/splash_cubit/splash_cubit.dart';
import 'app_module.dart';

initAuthModule() {
//! Bloc && Cubit
//? ...SplashCubit
  ls.registerFactory<SplashCubit>(() => SplashCubit(useCases: ls()));
//? ...OnBoardingCubit
  ls.registerFactory<OnBoardingCubit>(() => OnBoardingCubit(useCases: ls()));

  ls.registerFactory<RegisterBloc>(() => RegisterBloc(useCases: ls()));

//! UseCases
//? ...provide all usecases with singltone pattern
  ls.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(
        checkIsFirstLaunchUseCase: CheckIsFirstLaunchUseCase(repository: ls()),
        setIsFirstLaunchUseCase: SetIsFirstLaunchUseCase(repository: ls()),
        signInWithGoogleUseCase: SignInWithGoogleUseCase(authRepository: ls())),
  );

//! Repository
//? ...AuthRepository
  ls.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDao: ls(), socialAuthenticator: ls()),
  );

//! Datasources
//? ...local data source
  ls.registerLazySingleton<AuthDao>(
    () => AuthDaoImpl(prefs: ls()),
  );

//? ...remote data source
  ls.registerLazySingleton<SocialAuthenticator>(
      () => SocialAuthenticatorWithFirebase());
}
