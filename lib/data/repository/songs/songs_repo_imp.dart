import 'package:blog_app/data/sources/songs/songs_firebase_service.dart';
import 'package:blog_app/domain/repository/songs/songs.dart';
import 'package:blog_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class SongsRepoImp extends SongsRepository {
  @override
  Future<Either> getNewSongs() async {
    return await sl<SongsFirebaseService>().getNewSongs();
  }

  @override
  Future<Either> getPlaylist() async {
    return await sl<SongsFirebaseService>().getPlaylist();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await sl<SongsFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await sl<SongsFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    return await sl<SongsFirebaseService>().getUserFavoriteSongs();
  }
}
