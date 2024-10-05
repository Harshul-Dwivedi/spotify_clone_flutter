import 'package:blog_app/common/helpers/is_dark_mode.dart';
import 'package:blog_app/common/widgets/buttons/favorite_button.dart';
import 'package:blog_app/core/configs/theme/app_colors.dart';
import 'package:blog_app/domain/entities/songs/songs.dart';
import 'package:blog_app/presentation/home/bloc/playlist_cubit.dart';
import 'package:blog_app/presentation/home/bloc/playlist_state.dart';
import 'package:blog_app/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }

          if (state is PlayListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Playlist",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: context.isDarkMode
                                ? const Color(0xffC6C6C6)
                                : Colors.black),
                      ),
                      Text(
                        "See More",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: context.isDarkMode
                                ? const Color(0xffC6C6C6)
                                : Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _songs(state.songs),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongsEntity> songs) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SongPlayerPage(
                            songsEntity: songs[index],
                          )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
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
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          songs[index].artist,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(songs[index].duration.toString().replaceAll('.', ':')),
                    const SizedBox(
                      width: 10,
                    ),
                    FavoriteButton(songsEntity: songs[index]),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
        itemCount: songs.length);
  }
}
