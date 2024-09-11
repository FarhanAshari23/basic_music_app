import 'package:spotify/data/models/users/user_reqres.dart';

abstract class GetUserReqresState {}

class GetUserReqresLoading extends GetUserReqresState {}

class GetUserReqresLoaded extends GetUserReqresState {
  final List<UserReqresModel> users;
  GetUserReqresLoaded({
    required this.users,
  });
}

class GetUserReqresFailure extends GetUserReqresState {}
