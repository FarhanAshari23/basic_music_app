import 'package:dartz/dartz.dart';

import '../../../core/configs/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song_user.dart';

class GetUserSongsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongUserRepository>().getUserSongs();
  }
}
