import 'package:spotify/domain/entities/song/song_user.dart';

class SongUserModel {
  String? uIdSong;
  String? artist;
  String? duration;
  String? title;
  SongUserModel({
    required this.artist,
    required this.duration,
    required this.title,
  });

  SongUserModel.fromJson(Map<String, dynamic> data) {
    uIdSong = data['uId'];
    artist = data['artist'];
    duration = data['duration'];
    title = data['title'];
  }
}

extension SongUserModelX on SongUserModel {
  SongUserEntity toEntity() {
    return SongUserEntity(
      uId: uIdSong!,
      title: title!,
      artist: artist!,
      duration: duration!,
    );
  }
}
