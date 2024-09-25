import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/song_user.dart';
import 'package:spotify/data/sources/song/song_user_firebase_service.dart';
import 'package:spotify/service_locator.dart';

import '../../../domain/repository/song/song_user.dart';
import '../../models/song/update_song_req.dart';

class SongUserRepositoryImpl extends SongUserRepository {
  @override
  Future<Either> createSongUser(SongUserModel songModel) async {
    return await sl<SongUserFirebaseService>().createSongUser(songModel);
  }

  @override
  Future<Either> uploadCover(File coverFile) async {
    return await sl<SongUserFirebaseService>().uploadCover(coverFile);
  }

  @override
  Future<Either> uploadSong(File songFile) async {
    return await sl<SongUserFirebaseService>().uploadSong(songFile);
  }

  @override
  Future<Either> getUserSongs() async {
    return await sl<SongUserFirebaseService>().getUserSongs();
  }

  @override
  Future<Either> deleteUserSongs(String uIdSong) async {
    return await sl<SongUserFirebaseService>().deleteUserSongs(uIdSong);
  }

  @override
  Future<Either> updateUserSong(UpdateSongReq updateSongReq) async {
    return await sl<SongUserFirebaseService>().updateUserSong(updateSongReq);
  }
}
