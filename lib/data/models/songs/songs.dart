import 'package:blog_app/domain/entities/songs/songs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SongsModel {
  String? artist;
  num? duration;
  String? title;
  Timestamp? releaseDate;
  bool? isFavorite;
  String? songId;

  SongsModel(
      {required this.artist,
      required this.duration,
      required this.title,
      required this.releaseDate,
      required this.isFavorite,
      required this.songId});

  SongsModel.fromJson(Map<String, dynamic> data) {
    duration = data['duration'];
    artist = data['artist'];
    title = data['title'];
    releaseDate = data['releaseDate'];
  }
}

extension SongsModelX on SongsModel {
  SongsEntity toEntity() {
    return SongsEntity(
        songId: songId!,
        isFavorite: isFavorite!,
        artist: artist!,
        duration: duration!,
        title: title!,
        releaseDate: releaseDate!);
  }
}
