import 'package:blog_app/data/models/songs/songs.dart';
import 'package:blog_app/domain/entities/songs/songs.dart';
import 'package:blog_app/domain/usecases/songs/is_favorite.dart';
import 'package:blog_app/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SongsFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> getPlaylist();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongsFirebaseServiceImpl extends SongsFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongsEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongsModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteUsecase>().call(
          params: element.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left('An error occurred, Please try again.');
    }
  }

  @override
  Future<Either> getPlaylist() async {
    try {
      List<SongsEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongsModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteUsecase>().call(
          params: element.reference.id,
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left('An error occurred, Please try again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    ///ADD TO FAVORITE METHOD - INITIALISE AUTH AND FIRESTORE INSTANCE, GET CURRENT USER AND GET THE UID , CHECK IF SONG IS ALREADY FAVORITE BY COMPARING SONG ID,
    ///IT IT ALREADY EXISTS, REMOVE FROM FAV ELSE ADD IT .

    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      String uid = user!.uid;
      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('Users')
          .doc(uid)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSong.docs.isNotEmpty) {
        // GETS THE REFERENCE OF FIRST DOCUMENT FROM THE QUERY
        await favoriteSong.docs.first.reference.delete();
        isFavorite = false;
      } else {
        // FAVORITES IS A SUBCOLLECTION OF USERS
        firebaseFirestore
            .collection('Users')
            .doc(uid)
            .collection('Favorites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uid = user!.uid;
      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('Users')
          .doc(uid)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSong.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      List<SongsEntity> favoritesSongs = [];
      String uid = user!.uid;
      QuerySnapshot favoritesSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uid)
          .collection('Favorites')
          .get();

      for (var element in favoritesSnapshot.docs) {
        String songId = element['songId'];
        var song =
            await firebaseFirestore.collection('Songs').doc(songId).get();
        SongsModel songsModel = SongsModel.fromJson(song.data()!);
        songsModel.isFavorite = true;
        songsModel.songId = songId;
        favoritesSongs.add(songsModel.toEntity());
      }
      return Right(favoritesSongs);
    } catch (e) {
      return const Left("An error occurred");
    }
  }
}
