import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/auth/data/datasources/local/auth_dao.dart';
import 'package:mythic_todo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';

class MockAuthDao extends Mock implements AuthDao {}

void main() {
  late MockAuthDao mockAuthDao;
  late AuthRepository repository;

  setUp(() {
    mockAuthDao = MockAuthDao();
    repository = AuthRepositoryImpl(authDao: mockAuthDao);
  });

  group('isFirstLaunching repository', () {
    test('should return bool value from AuthDao(SharedPreferences)', () {
      // arrange
      when(() => mockAuthDao.isFirstLaunching()).thenAnswer((_) => true);
      // act
      final result = repository.isFirstLaunching();
      // assert
      expect(result, const Right(true));
    });

    test('''should return failure when 
      fail to get bool from AuthDao(SharedPreferences)''', () {
      // arrange
      when(() => mockAuthDao.isFirstLaunching())
          .thenThrow(AppSettingException());
      // act
      final result = repository.isFirstLaunching();
      // assert
      expect(result, Left(AppSettingFailure()));
    });
  });

  group('setFirstLaunch repository', () {
    test(
        'should return unit from AuthDao(SharedPreferences) when successfully insert value',
        () async {
      // arrange
      when(() => mockAuthDao.setFirstLaunch(isFirstLaunch: true))
          .thenAnswer((_) async => unit);
      // act
      final result = await repository.setFirstLaunch(isFirstLaunch: true);
      // assert
      expect(result, const Right(unit));
    });

    test('''should return failure when 
      fail to set bool into AuthDao(SharedPreferences)''', () async {
      // arrange
      when(() => mockAuthDao.setFirstLaunch(isFirstLaunch: true))
          .thenThrow(AppSettingException());
      // act
      final result = await repository.setFirstLaunch(isFirstLaunch: true);
      // assert
      expect(result, Left(AppSettingFailure()));
    });
  });
}
