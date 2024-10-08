import 'package:blog_app/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:blog_app/domain/usecases/songs/add_or_remove_fav.dart';
import 'package:blog_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdated(String songId) async {
    var result = await sl<AddOrRemoveFavUsecase>().call(
      params: songId,
    );

    result.fold((l) {}, (isFavorite) {
      emit(FavoriteButtonUpdated(isFavorite: isFavorite));
    });
  }
}
