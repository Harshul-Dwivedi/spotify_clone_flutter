import 'package:blog_app/data/repository/auth/auth_repo_imp.dart';
import 'package:blog_app/data/repository/songs/songs_repo_imp.dart';
import 'package:blog_app/data/sources/auth/auth_firebase_service.dart';
import 'package:blog_app/data/sources/songs/songs_firebase_service.dart';
import 'package:blog_app/domain/repository/auth/auth.dart';
import 'package:blog_app/domain/repository/songs/songs.dart';
import 'package:blog_app/domain/usecases/auth/get_user.dart';
import 'package:blog_app/domain/usecases/auth/signin.dart';
import 'package:blog_app/domain/usecases/auth/signup.dart';
import 'package:blog_app/domain/usecases/songs/add_or_remove_fav.dart';
import 'package:blog_app/domain/usecases/songs/get_favorite_songs.dart';
import 'package:blog_app/domain/usecases/songs/get_new_songs.dart';
import 'package:blog_app/domain/usecases/songs/get_playlist.dart';
import 'package:blog_app/domain/usecases/songs/is_favorite.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImplementation());

  sl.registerSingleton<SongsFirebaseService>(SongsFirebaseServiceImpl());

  sl.registerSingleton<SongsRepository>(SongsRepoImp());

  sl.registerSingleton<GetNewSongsUseCase>(GetNewSongsUseCase());

  sl.registerSingleton<GetPlaylistUsecase>(GetPlaylistUsecase());

  sl.registerSingleton<AuthRepository>(AuthRepoImpl());

  sl.registerSingleton<SignupUsecase>(SignupUsecase());

  sl.registerSingleton<SigninUsecase>(SigninUsecase());

  sl.registerSingleton<AddOrRemoveFavUsecase>(AddOrRemoveFavUsecase());

  sl.registerSingleton<IsFavoriteUsecase>(IsFavoriteUsecase());

  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());

  sl.registerSingleton<GetFavoriteSongsUsecase>(GetFavoriteSongsUsecase());
}
