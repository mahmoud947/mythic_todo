import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class CheckIsFirstLaunchUseCase {
  CheckIsFirstLaunchUseCase({required this.repository});
  final AuthRepository repository;
  Either<Failure, bool> call() {
    return repository.isFirstLaunching();
  }
}
