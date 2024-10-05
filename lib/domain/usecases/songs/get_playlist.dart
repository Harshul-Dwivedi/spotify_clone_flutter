import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/domain/repository/songs/songs.dart';
import 'package:blog_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetPlaylistUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getPlaylist();
  }
}
