import 'package:blog_app/domain/entities/songs/songs.dart';

abstract class NewSongsState {}

class NewSongsLoading extends NewSongsState {}

class NewSongsLoaded extends NewSongsState {
  final List<SongsEntity> songs;

  NewSongsLoaded({required this.songs});
}

class NewSongsLoadFailure extends NewSongsState {}
