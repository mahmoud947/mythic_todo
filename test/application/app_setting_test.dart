import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/application/app_constants.dart';
import 'package:mythic_todo/application/app_setting.dart';
import 'package:mythic_todo/application/app_setting_impl.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
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
  group(
    'isFirstLaunching',
    () {
      test(
          'should return bool value from application setting(SharedPreferences)',
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
      fail to get bool from from application setting(SharedPreferences)''',
          () async {
        // arrange
        when(() => mockSharedPreferences
                .getBool(AppConstants.IS_FIRST_LAUNCHING_APP_KEY))
            .thenThrow(AppSettingException());
        // act
        final result = appSettingImpl.isFirstLaunching();
        // assert
        expect(result, Left(AppSettingFailure()));
      });
    },
  );
}
