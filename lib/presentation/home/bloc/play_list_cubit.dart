import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_playlist.dart';
import 'package:spotify/service_locator.dart';

import 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());
  Future<void> getPlaylist() async {
    var returnedSongs = await sl<GetPlaylistUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(PlayListLoadFailure());
      },
      (data) {
        emit(
          PlayListLoaded(songs: data),
        );
      },
    );
  }
}
