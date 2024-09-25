import 'package:dartz/dartz.dart';

import '../../../core/configs/usecase/usecase.dart';
import '../../../data/models/song/update_song_req.dart';
import '../../../service_locator.dart';
import '../../repository/song/song_user.dart';

class UpdateSongUserUseCase implements Usecase<Either, UpdateSongReq> {
  @override
  Future<Either> call({UpdateSongReq? params}) async {
    return sl<SongUserRepository>().updateUserSong(params!);
  }
}
