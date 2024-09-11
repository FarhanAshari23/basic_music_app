import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/user/user_reqres_service.dart';
import 'package:spotify/domain/repository/user/user_reqres.dart';
import 'package:spotify/service_locator.dart';

class UserReqresRepositoryimpl extends UserReqresRepository {
  @override
  Future<Either> getUserReqres() async {
    return await sl<UserReqresService>().getUserReqres();
  }

  @override
  Future<Either> updateUserReqres() {
    // TODO: implement updateUserReqres
    throw UnimplementedError();
  }
}
