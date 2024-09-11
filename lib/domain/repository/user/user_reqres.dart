import 'package:dartz/dartz.dart';

abstract class UserReqresRepository {
  Future<Either> getUserReqres();
  Future<Either> updateUserReqres();
}
