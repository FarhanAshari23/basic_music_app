import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotify/domain/usecases/song/upload_song.dart';
import 'package:spotify/presentation/add%20music/bloc/add_song_state.dart';
import 'package:spotify/service_locator.dart';

class AddSongCubit extends Cubit<AddSongState> {
  AddSongCubit() : super(AddSongLoading());

  Future<void> uploadSong() async {
    var uploadedSong = await sl<UploadSongUserUseCase>().call();
    uploadedSong.fold(
      (l) {
        emit(AddSongFailed());
      },
      (file) {
        emit(AddSongLoaded(songFile: file));
      },
    );
  }
}
