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
    } on AppSettingException {
      return left(AppSettingFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> setFirstLaunch({required bool isFirstLaunch}) {
    // TODO: implement isFirstLaunching
    throw UnimplementedError();
  }
}
