import 'check_is_first_launch_use_case.dart';
import 'get_user_info_use_case.dart';
import 'set_is_first_launch_use_case.dart';
import 'sign_in_use_case.dart';
import 'sign_in_with_google_use_case.dart';
import 'sign_up_use_case.dart';

class AuthUseCases {
  AuthUseCases({
    required this.checkIsFirstLaunchUseCase,
    required this.setIsFirstLaunchUseCase,
    required this.signInWithGoogleUseCase,
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.getUserInfoUseCase,
  });
  final CheckIsFirstLaunchUseCase checkIsFirstLaunchUseCase;
  final SetIsFirstLaunchUseCase setIsFirstLaunchUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
}
