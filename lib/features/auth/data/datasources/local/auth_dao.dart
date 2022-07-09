import 'package:dartz/dartz.dart';

abstract class AuthDao {
  bool isFirstLaunching();

  Future<Unit> setFirstLaunch({required bool isFirstLaunch});
}
