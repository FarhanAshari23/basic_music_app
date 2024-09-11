import 'package:dartz/dartz.dart';
import 'package:spotify/core/configs/usecase/usecase.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class GetUserUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
