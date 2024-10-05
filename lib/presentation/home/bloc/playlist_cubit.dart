import 'package:blog_app/domain/usecases/songs/get_playlist.dart';
import 'package:blog_app/presentation/home/bloc/playlist_state.dart';
import 'package:blog_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlayListLoading());

  Future<void> getPlaylist() async {
    var returnedSongs = await sl<GetPlaylistUsecase>().call();
    returnedSongs.fold((l) {
      emit(PlayListLoadFailure());
    }, (data) {
      emit(PlayListLoaded(songs: data));
    });
  }
}
