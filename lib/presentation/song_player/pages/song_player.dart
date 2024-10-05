import 'package:blog_app/common/widgets/appbar/app_bar.dart';
import 'package:blog_app/common/widgets/buttons/favorite_button.dart';
import 'package:blog_app/core/configs/constants/app_urls.dart';
import 'package:blog_app/core/configs/theme/app_colors.dart';
import 'package:blog_app/domain/entities/songs/songs.dart';
import 'package:blog_app/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:blog_app/presentation/song_player/bloc/song_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongPlayerPage extends StatelessWidget {
  final SongsEntity songsEntity;
  const SongPlayerPage({super.key, required this.songsEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(
          "Now Playing",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailingButton: IconButton(
            onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadSongs(
              '${AppUrls.songFirestorage}${songsEntity.artist} - ${songsEntity.title}.mp3?${AppUrls.mediaAlt}'),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _songCover(context),
                const SizedBox(
                  height: 20,
                ),
                _songDetails(),
                const SizedBox(
                  height: 30,
                ),
                _songPlayer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  '${AppUrls.coverFirestorage}${songsEntity.artist} - ${songsEntity.title}.jpg?${AppUrls.mediaAlt}'))),
    );
  }

  Widget _songDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songsEntity.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              songsEntity.artist,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            )
          ],
        ),
        FavoriteButton(songsEntity: songsEntity),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
      if (state is SongPlayerLoading) {
        return CircularProgressIndicator();
      }
      if (state is SongPlayerLoaded) {
        return Column(
          children: [
            Slider(
                min: 0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(
                    context.read<SongPlayerCubit>().songPosition)),
                Text(formatDuration(
                    context.read<SongPlayerCubit>().songDuration)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                context.read<SongPlayerCubit>().playOrPauseSong();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
                child: Icon(context.read<SongPlayerCubit>().audioPlayer.playing
                    ? Icons.pause
                    : Icons.play_arrow),
              ),
            ),
          ],
        );
      }

      return Container();
    });
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }
}
