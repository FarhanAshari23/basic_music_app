import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/auth/is_logged_in.dart';
import 'package:spotify/presentation/choose%20mode/bloc/choose_mode_state.dart';
import 'package:spotify/service_locator.dart';

class ChooseModeCubit extends Cubit<ChooseModeState> {
  ChooseModeCubit() : super(ChooseModeSplash());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(ChooseModeAuthenticated());
    } else {
      emit(ChooseModeUnAuthenticated());
    }
  }
}
