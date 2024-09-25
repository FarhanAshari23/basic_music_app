import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotify/data/models/song/song_user.dart';
import 'package:spotify/data/models/song/update_song_req.dart';
import 'package:spotify/domain/entities/song/song_user.dart';

abstract class SongUserFirebaseService {
  Future<Either> getUserSongs();
  Future<Either> createSongUser(SongUserModel songUser);
  Future<Either> uploadSong(File songFile);
  Future<Either> uploadCover(File coverFile);
  Future<Either> deleteUserSongs(String uIdSong);
  Future<Either> updateUserSong(UpdateSongReq updateSongReq);
}

class SongUserFirebaseServiceImpl extends SongUserFirebaseService {
  @override
  Future<Either> createSongUser(SongUserModel songUser) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      var user = firebaseAuth.currentUser;
      final uId = user!.uid;
      DocumentReference documentReference = await firebaseFirestore
          .collection("Users")
          .doc(uId)
          .collection('My Songs')
          .add(
        {
          "artist": songUser.artist,
          "duration": songUser.duration,
          "title": songUser.title
        },
      );
      await documentReference.update({'uId': documentReference.id});
      return const Right("Upload songs was succesfull");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> uploadSong(File songFile) async {
    try {
      String fileName = songFile.path.split('/').last;
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      final storageRefference = firebaseStorage.ref().child('songs/$fileName');
      await storageRefference.putFile(songFile);
      return const Right('Upload song succes');
    } catch (e) {
      return const Left("Upload song fail, try again");
    }
  }

  @override
  Future<Either> uploadCover(File coverFile) async {
    try {
      String fileName = coverFile.path.split('/').last;
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      final storageRefference = firebaseStorage.ref().child('covers/$fileName');
      await storageRefference.putFile(coverFile);
      return const Right('Upload cover succes');
    } catch (e) {
      return const Left("Upload cover fail, try again");
    }
  }

  @override
  Future<Either> getUserSongs() async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      var user = firebaseAuth.currentUser;
      final uId = user!.uid;

      List<SongUserEntity> songsUser = [];
      var data = await firebaseFirestore
          .collection("Users")
          .doc(uId)
          .collection("My Songs")
          .get();
      for (var element in data.docs) {
        var songsUserModel = SongUserModel.fromJson(element.data());
        songsUser.add(
          songsUserModel.toEntity(),
        );
      }
      return Right(songsUser);
    } catch (e) {
      return const Left("Failed to get songs, please try again");
    }
  }

  @override
  Future<Either> deleteUserSongs(String uIdSong) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      final uId = user!.uid;

      await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection("My Songs")
          .doc(uIdSong)
          .delete();
      return const Right("Songs deleted succesfull");
    } catch (e) {
      return const Left("Song fail to delete, please try again");
    }
  }

  @override
  Future<Either> updateUserSong(UpdateSongReq updateSongReq) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      final uId = user!.uid;
      CollectionReference song =
          firebaseFirestore.collection("Users").doc(uId).collection("My Songs");
      DocumentReference docRef = song.doc(updateSongReq.uIdSong);
      await docRef.update({
        "artist": updateSongReq.artist,
        "duration": updateSongReq.duration,
        "title": updateSongReq.titleSong,
      });
      return const Right("Update Song Succesfull");
    } catch (e) {
      return const Left("Update Song Fail");
    }
  }
}
