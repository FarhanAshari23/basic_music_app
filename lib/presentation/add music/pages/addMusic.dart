// ignore_for_file: file_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/appbar/basic_appbar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/data/models/song/song_user.dart';
import 'package:spotify/domain/usecases/song/create_song_user.dart';
import 'package:spotify/domain/usecases/song/upload_song.dart';
import 'package:spotify/presentation/add%20music/bloc/add_song_cubit.dart';
import 'package:spotify/presentation/add%20music/bloc/add_song_state.dart';
import 'package:spotify/service_locator.dart';

import '../../../core/configs/assets/app_vectors.dart';
import '../../../domain/usecases/song/upload_cover.dart';

class AddMusic extends StatelessWidget {
  AddMusic({super.key});

  final TextEditingController _songTitleC = TextEditingController();
  final TextEditingController _songArtistC = TextEditingController();
  final TextEditingController _songDurationC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              rulesText(context),
              const SizedBox(height: 20),
              _songTextField(context, _songTitleC, "Song Title:"),
              const SizedBox(height: 20),
              _songTextField(context, _songArtistC, "Artist Name:"),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocProvider(
                    create: (context) => AddSongCubit()..uploadSong(),
                    child: BlocBuilder<AddSongCubit, AddSongState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            final result =
                                await FilePicker.platform.pickFiles();
                            final file = File(result!.files.single.path!);
                            String fileName = result.files.single.name;
                            var upload = await sl<UploadSongUserUseCase>()
                                .call(params: file);

                            return upload.fold(
                              (error) {
                                var snackbar = SnackBar(content: Text(error));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              },
                              (r) {
                                var snackbar = SnackBar(
                                  content: Text("Succes Add Song $fileName"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.primary,
                            ),
                            child: const Text(
                              'Add Song',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles();
                      final file = File(result!.files.single.path!);
                      String fileName = result.files.single.name;
                      var upload =
                          await sl<UploadCoverUserUseCase>().call(params: file);
                      return upload.fold(
                        (error) {
                          var snackbar = SnackBar(content: Text(error));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                        (r) {
                          var snackbar = SnackBar(
                            content: Text("Succes Add Cover $fileName"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary,
                      ),
                      child: const Text(
                        'Add Covers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BasicAppButton(
                  onPressed: () async {
                    var result = await sl<CreateSongUserUseCase>().call(
                      params: SongUserModel(
                        artist: _songArtistC.text.toString(),
                        duration: _songDurationC.text.toString(),
                        title: _songTitleC.text.toString(),
                      ),
                    );
                    return result.fold(
                      (error) {
                        var snackbar = SnackBar(content: Text(error));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      (r) {
                        _songArtistC.clear();
                        _songDurationC.clear();
                        _songTitleC.clear();
                        var snackbar =
                            const SnackBar(content: Text("Succes Add Music"));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                    );
                  },
                  tittle: "Add Music")
            ],
          ),
        ),
      ),
    );
  }

  Widget rulesText(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Please Read These Rules Before Add Music!"),
        Text(
            "1: Format file song title when upload is\n'Artist Name -SongTitle', upload in .mp3 and with lowecase"),
        Text(
            "2: Format file song cover when upload is\n'SongTitle', upload in .jpeg and with lowecase"),
        Text(
          "3: Please enter the artist name and song title in the field according to the name of the file to be uploaded.",
        )
      ],
    );
  }

  Widget _songTextField(
    BuildContext context,
    TextEditingController controller,
    String hinttext,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
