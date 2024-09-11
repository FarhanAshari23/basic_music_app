import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/user/get_user_reqres.dart';
import 'package:spotify/presentation/home/bloc/get_user_reqres_state.dart';
import 'package:spotify/service_locator.dart';

class GetUserReqresCubit extends Cubit<GetUserReqresState> {
  GetUserReqresCubit() : super(GetUserReqresLoading());

  Future<void> getUserReqres() async {
    var returnedUserReqres = await sl<GetUserReqresUseCase>().call();

    returnedUserReqres.fold(
      (l) {
        emit(GetUserReqresFailure());
      },
      (users) {
        emit(
          GetUserReqresLoaded(users: users),
        );
      },
    );
  }
}
