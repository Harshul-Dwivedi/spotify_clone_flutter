import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/domain/repository/songs/songs.dart';
import 'package:blog_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class AddOrRemoveFavUsecase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
