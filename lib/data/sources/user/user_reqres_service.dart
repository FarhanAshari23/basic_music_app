import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/data/models/users/user_reqres.dart';

abstract class UserReqresService {
  Future<Either> getUserReqres();
  Future<Either> updateUserReqres();
}

class UserReqresServiceImpl extends UserReqresService {
  @override
  Future<Either> getUserReqres() async {
    List<UserReqresModel> allUser = [];
    try {
      var myresponse =
          await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
      List data =
          (json.decode(myresponse.body) as Map<String, dynamic>)['data'];
      for (var element in data) {
        allUser.add(UserReqresModel.fromJson(element));
      }

      return Right(allUser);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> updateUserReqres() {
    // TODO: implement updateUserReqres
    throw UnimplementedError();
  }
}
