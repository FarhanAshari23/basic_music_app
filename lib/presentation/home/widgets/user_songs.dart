import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/data/models/song/update_song_req.dart';
import 'package:spotify/domain/usecases/song/delete_song_user.dart';
import 'package:spotify/domain/usecases/song/update_user_song.dart';
import 'package:spotify/presentation/home/bloc/get_user_song_cubit.dart';
import 'package:spotify/presentation/home/bloc/get_user_song_state.dart';
import 'package:spotify/service_locator.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song_user.dart';
import '../../song player/pages/song_user_player.dart';

class UserSongs extends StatelessWidget {
  UserSongs({super.key});

  final TextEditingController _songTitleC = TextEditingController();
  final TextEditingController _songArtistC = TextEditingController();
  final TextEditingController _songDurationC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetUserSongCubit()..getUserSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<GetUserSongCubit, GetUserSongState>(
          builder: (context, state) {
            if (state is GetUserSongStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetUserSongStateLoaded) {
              if (state.songsUser.isEmpty) {
                return const Center(
                  child: Text('Add Your Songs in Profile Page'),
                );
              } else {
                return _songs(state.songsUser, context);
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongUserEntity> songs, BuildContext contextPopOver) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SongUserPlayer(
                songEntity: songs[index],
              ),
            ),
          ),
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '${AppURLs.coverFirestorage}${songs[index].title.toLowerCase()}.jpeg?${AppURLs.mediaAlt}'),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 40,
                        height: 40,
                        transform: Matrix4.translationValues(10, 10, 0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode
                                ? AppColors.darkGrey
                                : const Color(0xffE6E6E6)),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: context.isDarkMode
                              ? const Color(0xff959595)
                              : const Color(0xff555555),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          songs[index].artist,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => showPopover(
                        context: contextPopOver,
                        bodyBuilder: (context) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: SizedBox(
                                          height: 500,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Warning, edit name artist and title song can effect to the song file(See terms when upload file). So please edit carefully",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 20),
                                                TextField(
                                                  controller: _songArtistC,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        songs[index].artist,
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                TextField(
                                                  controller: _songTitleC,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        songs[index].title,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                BasicAppButton(
                                                  onPressed: () async {
                                                    var result = await sl<
                                                            UpdateSongUserUseCase>()
                                                        .call(
                                                      params: UpdateSongReq(
                                                        uIdSong:
                                                            songs[index].uId,
                                                        artist: _songArtistC
                                                            .text
                                                            .toString(),
                                                        titleSong: _songTitleC
                                                            .text
                                                            .toString(),
                                                        duration: _songDurationC
                                                            .text
                                                            .toString(),
                                                      ),
                                                    );
                                                    result.fold(
                                                      (error) {
                                                        var snackbar =
                                                            const SnackBar(
                                                          content: Text(
                                                              "Fail to update song"),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackbar);
                                                      },
                                                      (r) {
                                                        var snackbar =
                                                            const SnackBar(
                                                          content: Text(
                                                              "Song updated succesfully"),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackbar);
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  },
                                                  tittle: "Change Song Data",
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  color: AppColors.lightBackground,
                                  width: 120,
                                  height: 50,
                                  child: const Center(
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var delete = await sl<DeleteSongUserUseCase>()
                                      .call(params: songs[index].uId);
                                  return delete.fold(
                                    (error) {
                                      var snackbar = const SnackBar(
                                        content: Text("Fail to delete song"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    },
                                    (r) {
                                      var snackbar = const SnackBar(
                                        content:
                                            Text("Song deleted succesfully"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                child: Container(
                                  color: AppColors.darkBackground,
                                  width: 120,
                                  height: 50,
                                  child: const Center(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        direction: PopoverDirection.bottom,
                        width: 120,
                        height: 100,
                        backgroundColor: Colors.deepPurple.shade300,
                      ),
                      icon: Icon(
                        Icons.more_vert,
                        color: context.isDarkMode
                            ? const Color(0xff959595)
                            : const Color(0xff555555),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemCount: songs.length,
    );
  }
}
