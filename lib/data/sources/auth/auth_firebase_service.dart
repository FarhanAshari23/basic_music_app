import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/models/auth/user.dart';
import 'package:spotify/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SignInUserReq signInUserReq);
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.passwword,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set(
        {
          'name': createUserReq.fullName,
          "email": data.user?.email,
        },
      );

      return const Right("Signup was Succesful");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is to weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exist with that email';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signin(SignInUserReq signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserReq.email,
        password: signInUserReq.passwword,
      );

      return const Right("Signin was Succesful");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'The user not found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL =
          firebaseAuth.currentUser?.photoURL ?? AppImages.defaultPP;
      UserEntity userEntity = userModel.toEntity();
      return right(userEntity);
    } catch (e) {
      return left('An Error Occured');
    }
  }
}
