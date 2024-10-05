import 'package:blog_app/domain/usecases/songs/get_new_songs.dart';
import 'package:blog_app/presentation/home/bloc/news_songs_state.dart';
import 'package:blog_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSongsCubit extends Cubit<NewSongsState> {
  NewsSongsCubit() : super(NewSongsLoading());

  Future<void> getNewSongs() async {
    var returnedSongs = await sl<GetNewSongsUseCase>().call();
    returnedSongs.fold((l) {
      emit(NewSongsLoadFailure());
    }, (data) {
      emit(NewSongsLoaded(songs: data));
    });
  }
}
