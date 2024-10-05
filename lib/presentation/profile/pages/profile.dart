import 'package:blog_app/common/helpers/is_dark_mode.dart';
import 'package:blog_app/common/widgets/appbar/app_bar.dart';
import 'package:blog_app/common/widgets/buttons/favorite_button.dart';
import 'package:blog_app/core/configs/constants/app_urls.dart';
import 'package:blog_app/presentation/profile/bloc/favorite_cubit.dart';
import 'package:blog_app/presentation/profile/bloc/favorite_state.dart';
import 'package:blog_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:blog_app/presentation/profile/bloc/profile_state.dart';
import 'package:blog_app/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hideBackButton: false,
        backgroundColor: context.isDarkMode ? Color(0xff2C2B2B) : Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(
            height: 20,
          ),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          }
          if (state is ProfileInfoLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(state.userEntity.imageUrl!))),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(state.userEntity.email!),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.userEntity.fullName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            );
          }
          if (state is ProfileInfoFailure) {
            return const Center(child: Text("Please Try Again!"));
          }
          return Container();
        }),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("FAVORITE SONGS"),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongCubit, FavoriteSongState>(
                builder: (context, state) {
              if (state is FavoriteSongLoading) {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }

              if (state is FavoriteSongLoaded) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SongPlayerPage(
                                          songsEntity:
                                              state.favoriteSongs[index])));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${AppUrls.coverFirestorage}${state.favoriteSongs[index].artist} - ${state.favoriteSongs[index].title}.jpg?${AppUrls.mediaAlt}'))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.favoriteSongs[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      state.favoriteSongs[index].artist,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(state.favoriteSongs[index].duration
                                    .toString()
                                    .replaceAll('.', ':')),
                                const SizedBox(
                                  width: 10,
                                ),
                                FavoriteButton(
                                  songsEntity: state.favoriteSongs[index],
                                  key: UniqueKey(),
                                  callback: () {
                                    context
                                        .read<FavoriteSongCubit>()
                                        .removeSongs(index);
                                  },
                                ),
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
                    itemCount: state.favoriteSongs.length);
              }
              if (state is FavoriteSongFailure) {
                return const Center(child: Text("Please Try Again"));
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}
