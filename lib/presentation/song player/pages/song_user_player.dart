import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song_user.dart';
import '../bloc/song_player_cubit.dart';
import '../bloc/song_player_state.dart';

class SongUserPlayer extends StatelessWidget {
  final SongUserEntity songEntity;
  const SongUserPlayer({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadSong(
              '${AppURLs.musicFirestorage}${songEntity.artist.toLowerCase()} -${songEntity.title.toLowerCase()}.mp3?${AppURLs.mediaAlt}'),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20),
              _songDetail(),
              const SizedBox(height: 20),
              _songPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              '${AppURLs.coverFirestorage}${songEntity.title.toLowerCase()}.jpeg?${AppURLs.mediaAlt}'),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              songEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              Slider(
                min: 0.0,
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songPosition,
                    ),
                  ),
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songDuration,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => context.read<SongPlayerCubit>().playOrPauseSong(),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
