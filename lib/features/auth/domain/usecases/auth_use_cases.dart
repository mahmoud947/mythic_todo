import 'check_is_first_launch_use_case.dart';
import 'set_is_first_launch_use_case.dart';

class AuthUseCases {
  AuthUseCases({
    required this.checkIsFirstLaunchUseCase,
    required this.setIsFirstLaunchUseCase,
  });
  final CheckIsFirstLaunchUseCase checkIsFirstLaunchUseCase;
  final SetIsFirstLaunchUseCase setIsFirstLaunchUseCase;
}
