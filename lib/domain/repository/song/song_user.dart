import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/song_user.dart';

import '../../../data/models/song/update_song_req.dart';

abstract class SongUserRepository {
  Future<Either> getUserSongs();
  Future<Either> createSongUser(SongUserModel songModel);
  Future<Either> uploadSong(File songFile);
  Future<Either> uploadCover(File coverFile);
  Future<Either> deleteUserSongs(String uIdSong);
  Future<Either> updateUserSong(UpdateSongReq updateSongReq);
}
