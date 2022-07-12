import 'package:dartz/dartz.dart';

abstract class AuthDao {
  bool isFirstLaunching();
//TODO: remove function args
  Future<Unit> setFirstLaunch({required bool isFirstLaunch});
}
