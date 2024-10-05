import 'package:cloud_firestore/cloud_firestore.dart';

class SongsEntity {
  final String artist;
  final num duration;
  final String title;
  final Timestamp releaseDate;
  final bool isFavorite;
  final String songId;

  SongsEntity(
      {required this.artist,
      required this.duration,
      required this.title,
      required this.releaseDate,
      required this.isFavorite,
      required this.songId});
}
