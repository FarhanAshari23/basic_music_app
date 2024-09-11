import 'package:dartz/dartz.dart';
import 'package:spotify/domain/repository/user/user_reqres.dart';

import '../../../core/configs/usecase/usecase.dart';
import '../../../service_locator.dart';

class GetUserReqresUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<UserReqresRepository>().getUserReqres();
  }
}
