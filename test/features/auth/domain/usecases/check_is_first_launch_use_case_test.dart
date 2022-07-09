import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:mythic_todo/features/auth/domain/usecases/check_is_first_launch_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late CheckIsFirstLaunchUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = CheckIsFirstLaunchUseCase(repository: mockAuthRepository);
  });

  test('should return bool value from Auth repository', () {
    // arrange
    when(() => mockAuthRepository.isFirstLaunching())
        .thenReturn(const Right(true));
    // act
    final result = useCase();
    // assert
    expect(result, const Right(true));

    verify(() => mockAuthRepository.isFirstLaunching());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
