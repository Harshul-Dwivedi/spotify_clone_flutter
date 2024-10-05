import 'package:blog_app/domain/entities/songs/songs.dart';
import 'package:blog_app/domain/usecases/songs/get_favorite_songs.dart';
import 'package:blog_app/presentation/profile/bloc/favorite_state.dart';
import 'package:blog_app/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class FavoriteSongCubit extends Cubit<FavoriteSongState> {
  FavoriteSongCubit() : super(FavoriteSongLoading());

  List<SongsEntity> favoriteSongs = [];
  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUsecase>().call();
    result.fold((l) {
      emit(FavoriteSongFailure());
    }, (r) {
      favoriteSongs = r;
      emit(FavoriteSongLoaded(favoriteSongs: favoriteSongs));
    });
  }

  Future<void> removeSongs(int index) async {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongLoaded(favoriteSongs: favoriteSongs));
  }
}
