import 'package:dartz/dartz.dart';

import '../../../core/configs/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song.dart';

class AddOrRemoveFavoriteSongUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSong(params!);
  }
}
