import 'package:blog_app/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:blog_app/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:blog_app/core/configs/theme/app_colors.dart';
import 'package:blog_app/domain/entities/songs/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final SongsEntity songsEntity;
  final Function? callback;
  const FavoriteButton({super.key, required this.songsEntity, this.callback});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
          builder: (context, state) {
        if (state is FavoriteButtonInitial) {
          return IconButton(
              onPressed: () async {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songsEntity.songId);
                if (callback != null) {
                  callback!();
                }
              },
              icon: Icon(
                songsEntity.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ));
        }
        if (state is FavoriteButtonUpdated) {
          return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songsEntity.songId);
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ));
        }
        return Container();
      }),
    );
  }
}
