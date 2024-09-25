import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/song_user.dart';

import '../../../core/configs/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song_user.dart';

class CreateSongUserUseCase implements Usecase<Either, SongUserModel> {
  @override
  Future<Either> call({SongUserModel? params}) async {
    return sl<SongUserRepository>().createSongUser(params!);
  }
}
