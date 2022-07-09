import 'package:dartz/dartz.dart';
import 'package:mythic_todo/application/app_constants.dart';
import 'package:mythic_todo/application/app_setting.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingImpl implements AppSetting {
  AppSettingImpl({required this.prefs});
  final SharedPreferences prefs;

  @override
  Either<Failure, bool> isFirstLaunching() {
    try {
      final result = prefs.getBool(AppConstants.IS_FIRST_LAUNCHING_APP_KEY);
      if (result != null) {
        return right(result);
      } else {
        return right(false);
      }
    } catch (e) {
      return left(AppSettingFailure(message: 'unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Unit>> setFirstLaunch(
      {required bool isFirstLaunch}) async {
    try {
      final result = await prefs.setBool(
          AppConstants.IS_FIRST_LAUNCHING_APP_KEY, isFirstLaunch);
      if (result) {
        return right(unit);
      } else {
        return left(AppSettingFailure(message: 'un saved error'));
      }
    } catch (e) {
      return left(AppSettingFailure(message: 'unexpected error occurred'));
    }
  }
}
