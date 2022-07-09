import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/application/app_constants.dart';
import 'package:mythic_todo/application/app_setting.dart';
import 'package:mythic_todo/application/app_setting_impl.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/auth/data/datasources/local/auth_dao.dart';
import 'package:mythic_todo/features/auth/data/datasources/local/auth_dao_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AuthDao authDao;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    authDao = AuthDaoImpl(prefs: mockSharedPreferences);
  });

  test('should return bool value from AuthDao(SharedPreferences)', () async {
    // arrange
    when(() => mockSharedPreferences.getBool(
        AppConstants.IS_FIRST_LAUNCHING_APP_KEY)).thenAnswer((_) => true);
    // act
    final result = authDao.isFirstLaunching();
    // assert
    expect(result, true);
  });

  test(
      'should return unit when successfully insert bool value in AuthDao(SharedPreferences)',
      () async {
    // arrange
    when(() => mockSharedPreferences.setBool(
            AppConstants.IS_FIRST_LAUNCHING_APP_KEY, true))
        .thenAnswer((_) async => true);
    // act
    final result = await authDao.setFirstLaunch(isFirstLaunch: true);
    // assert
    expect(result, unit);
  });
}
