import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class SetIsFirstLaunchUseCase {
  SetIsFirstLaunchUseCase({required this.repository});
  final AuthRepository repository;
  Future<Either<Failure, Unit>> call({required bool isFirstLaunch}) {
    return repository.setFirstLaunch(isFirstLaunch: isFirstLaunch);
  }
}
