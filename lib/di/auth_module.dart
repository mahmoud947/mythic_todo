import '../core/usecase/text_field_validation_use_case.dart';
import '../features/auth/data/datasources/remote/authenticator.dart';
import '../features/auth/data/datasources/remote/authenticator_with_firebase.dart';
import '../features/auth/data/datasources/remote/social_authenticator.dart';
import '../features/auth/data/datasources/remote/social_authenticator_with_firebase.dart';
import '../features/auth/domain/usecases/get_user_info_use_case.dart';
import '../features/auth/domain/usecases/sign_in_use_case.dart';
import '../features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import '../features/auth/domain/usecases/sign_up_use_case.dart';
import '../features/auth/domain/usecases/validation/auth_form_validation_use_cases.dart';
import '../features/auth/domain/usecases/validation/confirm_password_validation_use_case.dart';
import '../features/auth/domain/usecases/validation/email_validation_use_case.dart';
import '../features/auth/domain/usecases/validation/password_validation_use_case.dart';
import '../features/auth/presentation/bloc/register/register_bloc.dart';
import '../features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';

import '../features/auth/data/datasources/local/auth_dao.dart';
import '../features/auth/data/datasources/local/auth_dao_impl.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/auth_use_cases.dart';
import '../features/auth/domain/usecases/check_is_first_launch_use_case.dart';
import '../features/auth/domain/usecases/set_is_first_launch_use_case.dart';
import '../features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import '../features/auth/presentation/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../features/auth/presentation/cubit/splash_cubit/splash_cubit.dart';
import 'app_module.dart';

initAuthModule() {
//! Bloc && Cubit
//? ...SplashCubit
  ls.registerFactory<SplashCubit>(() => SplashCubit(useCases: ls()));
//? ...OnBoardingCubit
  ls.registerFactory<OnBoardingCubit>(() => OnBoardingCubit(useCases: ls()));
//? ...RegisterBloc
  ls.registerFactory<RegisterBloc>(() => RegisterBloc(useCases: ls()));
//? ...SignUpBloc
  ls.registerFactory<SignUpBloc>(() => SignUpBloc(
        authFormValidationUseCase: ls(),
        authUseCases: ls(),
      ));
//? ...SignInBloc
  ls.registerFactory<SignInBloc>(() => SignInBloc(
        authFormValidationUseCase: ls(),
        authUseCases: ls(),
      ));

//! UseCases
//? ...provide all usecases with singltone pattern
  ls.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(
      checkIsFirstLaunchUseCase: CheckIsFirstLaunchUseCase(repository: ls()),
      setIsFirstLaunchUseCase: SetIsFirstLaunchUseCase(repository: ls()),
      signInWithGoogleUseCase: SignInWithGoogleUseCase(authRepository: ls()),
      signUpUseCase: SignUpUseCase(authRepository: ls()),
      signInUseCase: SignInUseCase(authRepository: ls()),
      getUserInfoUseCase: GetUserInfoUseCase(authRepository: ls()),
    ),
  );

  ls.registerLazySingleton<AuthFormValidationUseCase>(() =>
      AuthFormValidationUseCase(
        confirmPasswordValidationUseCase: ConfirmPasswordValidationUseCase(),
        emailValidationUseCase: EmailValidationUseCase(),
        passwordValidationUseCase: PasswordValidationUseCase(),
        firstNameValidationUseCase: TextFieldValidationUseCase(),
        lastNameValidationUseCase: TextFieldValidationUseCase(),
      ));

//! Repository
//? ...AuthRepository
  ls.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkHelper: ls(),
      authDao: ls(),
      socialAuthenticator: ls(),
      authenticator: ls(),
    ),
  );

//! Datasources
//? ...local data source
  ls.registerLazySingleton<AuthDao>(
    () => AuthDaoImpl(prefs: ls()),
  );

//? ...remote data source
  ls.registerLazySingleton<SocialAuthenticator>(
      () => SocialAuthenticatorWithFirebase());
  ls.registerLazySingleton<Authenticator>(() => AuthenticatorWithFirebase());
}
