import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/application/app_constants.dart';
import 'package:mythic_todo/application/app_setting.dart';
import 'package:mythic_todo/application/app_setting_impl.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AppSetting appSettingImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    appSettingImpl = AppSettingImpl(prefs: mockSharedPreferences);
  });

  group('isFirstLaunching', () {
    test('should return bool value from application setting(SharedPreferences)',
        () async {
      // arrange
      when(() => mockSharedPreferences.getBool(
          AppConstants.IS_FIRST_LAUNCHING_APP_KEY)).thenAnswer((_) => true);
      // act
      final result = appSettingImpl.isFirstLaunching();
      // assert
      expect(result, const Right(true));
    });

    test('''should return failure when 
      fail to get bool from application setting(SharedPreferences)''',
        () async {
      // arrange
      when(() => mockSharedPreferences.getBool(
          AppConstants.IS_FIRST_LAUNCHING_APP_KEY)).thenThrow(Exception());
      // act
      final result = appSettingImpl.isFirstLaunching();
      // assert
      expect(result,
          Left(AppSettingFailure(message: 'unexpected error occurred')));
    });
  });

  group('setFirstLaunch', () {
    test(
        'should return unit when successfully insert bool value in application setting(SharedPreferences)',
        () async {
      // arrange
      when(() => mockSharedPreferences.setBool(
              AppConstants.IS_FIRST_LAUNCHING_APP_KEY, true))
          .thenAnswer((_) async => true);
      // act
      final result = await appSettingImpl.setFirstLaunch(isFirstLaunch: true);
      // assert
      expect(result, const Right(unit));
    });

    test('''should return failure(un saved error) when 
      fail in insert bool value in application setting(SharedPreferences)''',
        () async {
      // arrange
      when(() => mockSharedPreferences.setBool(
              AppConstants.IS_FIRST_LAUNCHING_APP_KEY, true))
          .thenAnswer((invocation) async => false);
      // act
      final result = await appSettingImpl.setFirstLaunch(isFirstLaunch: true);
      // assert
      expect(result, Left(AppSettingFailure(message: 'un saved error')));
    });

    test('''should return failure(unexpected error occurred) when 
      fail in insert bool value in application setting(SharedPreferences)''',
        () async {
      // arrange
      when(() => mockSharedPreferences.setBool(
              AppConstants.IS_FIRST_LAUNCHING_APP_KEY, true))
          .thenThrow(Exception());
      // act
      final result = await appSettingImpl.setFirstLaunch(isFirstLaunch: true);
      // assert
      expect(result,
          Left(AppSettingFailure(message: 'unexpected error occurred')));
    });
  });
}
