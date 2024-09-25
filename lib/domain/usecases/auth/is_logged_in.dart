import 'package:spotify/core/configs/usecase/usecase.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class IsLoggedInUseCase implements Usecase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}
