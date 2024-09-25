import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_user_songs.dart';
import 'package:spotify/presentation/home/bloc/get_user_song_state.dart';
import 'package:spotify/service_locator.dart';

class GetUserSongCubit extends Cubit<GetUserSongState> {
  GetUserSongCubit() : super(GetUserSongInitial());

  Future<void> getUserSongs() async {
    emit(GetUserSongStateLoading());
    var returnedUserSongs = await sl<GetUserSongsUseCase>().call();
    returnedUserSongs.fold(
      (l) {
        emit(
          GetUserSongStateFailure(),
        );
      },
      (data) {
        emit(
          GetUserSongStateLoaded(songsUser: data),
        );
      },
    );
  }
}
