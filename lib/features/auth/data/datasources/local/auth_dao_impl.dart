import 'package:dartz/dartz.dart';
import 'package:mythic_todo/application/app_constants.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_dao.dart';

class AuthDaoImpl implements AuthDao {
  AuthDaoImpl({required this.prefs});
  final SharedPreferences prefs;
  @override
  bool isFirstLaunching() {
    final result = prefs.getBool(AppConstants.IS_FIRST_LAUNCHING_APP_KEY);
    if (result != null) {
      return result;
    } else {
      throw AppSettingException(message: 'unexpected error occurred');
    }
  }

  @override
  Future<Unit> setFirstLaunch({required bool isFirstLaunch}) async {
    final result = await prefs.setBool(
        AppConstants.IS_FIRST_LAUNCHING_APP_KEY, isFirstLaunch);
    if (result) {
      return Future.value(unit);
    } else {
      throw AppSettingException(message: 'un saved error');
    }
  }
}
