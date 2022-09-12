import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../application/app_constants.dart';
import '../../../../../core/error/error_strings.dart';
import '../../../../../core/error/exceptions.dart';
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
      return false;
    }
  }

  @override
  Future<Unit> setFirstLaunch({required bool isFirstLaunch}) async {
    final result = await prefs.setBool(
        AppConstants.IS_FIRST_LAUNCHING_APP_KEY, isFirstLaunch);
    if (result) {
      return Future.value(unit);
    } else {
      throw AppSettingException(message: ErrorString.unSavedError);
    }
  }
}
