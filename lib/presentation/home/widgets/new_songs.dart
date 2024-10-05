import 'package:blog_app/common/helpers/is_dark_mode.dart';
import 'package:blog_app/core/configs/constants/app_urls.dart';
import 'package:blog_app/core/configs/theme/app_colors.dart';
import 'package:blog_app/domain/entities/songs/songs.dart';
import 'package:blog_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:blog_app/presentation/home/bloc/news_songs_state.dart';
import 'package:blog_app/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NewsSongsCubit()..getNewSongs(),
        child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongsCubit, NewSongsState>(
            builder: (context, state) {
              if (state is NewSongsLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }
              if (state is NewSongsLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: _songs(state.songs),
                );
              }
              return Container();
            },
          ),
        ));
  }

  Widget _songs(List<SongsEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
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
            child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${AppUrls.coverFirestorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppUrls.mediaAlt}'))),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 30,
                            width: 30,
                            transform: Matrix4.translationValues(5, 5, 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDarkMode
                                  ? AppColors.darkGrey
                                  : const Color(0xffE6E6E6),
                            ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      songs[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      songs[index].artist,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ],
                )),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 14,
          );
        },
        itemCount: songs.length);
  }
}
