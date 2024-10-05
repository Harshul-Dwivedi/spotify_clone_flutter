import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/domain/repository/songs/songs.dart';
import 'package:blog_app/service_locator.dart';

class IsFavoriteUsecase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
