import 'package:blog_app/domain/entities/songs/songs.dart';

abstract class FavoriteSongState {}

class FavoriteSongLoading extends FavoriteSongState {}

class FavoriteSongLoaded extends FavoriteSongState {
  final List<SongsEntity> favoriteSongs;

  FavoriteSongLoaded({required this.favoriteSongs});
}

class FavoriteSongFailure extends FavoriteSongState {}
