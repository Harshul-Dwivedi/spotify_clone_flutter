import 'package:blog_app/domain/entities/songs/songs.dart';

abstract class PlaylistState {}

class PlayListLoading extends PlaylistState {}

class PlayListLoaded extends PlaylistState {
  final List<SongsEntity> songs;

  PlayListLoaded({required this.songs});
}

class PlayListLoadFailure extends PlaylistState {}
