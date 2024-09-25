import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/configs/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song_user.dart';

class UploadCoverUserUseCase implements Usecase<Either, File> {
  @override
  Future<Either> call({File? params}) async {
    return sl<SongUserRepository>().uploadCover(params!);
  }
}
