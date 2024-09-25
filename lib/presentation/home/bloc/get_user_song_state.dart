import '../../../domain/entities/song/song_user.dart';

abstract class GetUserSongState {}

class GetUserSongInitial extends GetUserSongState {}

class GetUserSongStateLoading extends GetUserSongState {}

class GetUserSongStateLoaded extends GetUserSongState {
  final List<SongUserEntity> songsUser;

  GetUserSongStateLoaded({
    required this.songsUser,
  });
}

class GetUserSongStateFailure extends GetUserSongState {}
