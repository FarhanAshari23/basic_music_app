import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/data/models/users/user_reqres.dart';
import 'package:spotify/presentation/home/bloc/get_user_reqres_cubit.dart';
import 'package:spotify/presentation/home/bloc/get_user_reqres_state.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetUserReqresCubit()..getUserReqres(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<GetUserReqresCubit, GetUserReqresState>(
          builder: (context, state) {
            if (state is GetUserReqresLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetUserReqresLoaded) {
              return _userReqres(state.users);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _userReqres(List<UserReqresModel> users) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index == users.length) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        height: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email:'),
                              ),
                              const SizedBox(height: 12),
                              const TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password:'),
                              ),
                              const SizedBox(height: 20),
                              BasicAppButton(
                                onPressed: () {},
                                tittle: "Add Artist",
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text('Add users'),
            ),
          );
        }
        return Container(
          width: 180,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      users[index].avatar,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${users[index].firstName} ${users[index].lastName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                users[index].email,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemCount: users.length + 1,
    );
  }
}
