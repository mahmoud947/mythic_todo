import 'package:mythic_todo/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:mythic_todo/features/auth/domain/usecases/sign_up_use_case.dart';

import 'check_is_first_launch_use_case.dart';
import 'set_is_first_launch_use_case.dart';

class AuthUseCases {
  AuthUseCases({
    required this.checkIsFirstLaunchUseCase,
    required this.setIsFirstLaunchUseCase,
    required this.signInWithGoogleUseCase,
    required this.signUpUseCase,
  });
  final CheckIsFirstLaunchUseCase checkIsFirstLaunchUseCase;
  final SetIsFirstLaunchUseCase setIsFirstLaunchUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignUpUseCase signUpUseCase;
}
