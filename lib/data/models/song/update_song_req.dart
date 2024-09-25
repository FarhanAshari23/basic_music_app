class UpdateSongReq {
  final String uIdSong;
  final String artist;
  final String titleSong;
  final String duration;

  UpdateSongReq({
    required this.uIdSong,
    required this.artist,
    required this.titleSong,
    required this.duration,
  });
}
