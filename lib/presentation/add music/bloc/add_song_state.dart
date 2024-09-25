import 'dart:io';

abstract class AddSongState {}

class AddSongLoading extends AddSongState {}

class AddSongLoaded extends AddSongState {
  final File songFile;

  AddSongLoaded({
    required this.songFile,
  });
}

class AddSongFailed extends AddSongState {}
