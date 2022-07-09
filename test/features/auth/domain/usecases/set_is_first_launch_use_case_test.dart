import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:mythic_todo/features/auth/domain/usecases/set_is_first_launch_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SetIsFirstLaunchUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SetIsFirstLaunchUseCase(repository: mockAuthRepository);
  });

  test(
      'should return unit from AuthRepository when inserted value successfully',
      () async {
    // arrange
    when(() => mockAuthRepository.setFirstLaunch(isFirstLaunch: true))
        .thenAnswer((_) async => const Right(unit));
    // act
    final result = await useCase(isFirstLaunch: true);
    // assert
    expect(result, const Right(unit));

    verify(() => mockAuthRepository.setFirstLaunch(isFirstLaunch: true));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
