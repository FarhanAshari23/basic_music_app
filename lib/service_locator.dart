import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/user/user_reqres_repository.dart';
import 'package:spotify/data/sources/user/user_reqres_service.dart';
import 'package:spotify/domain/repository/user/user_reqres.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify/domain/usecases/song/get_playlist.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify/domain/usecases/user/get_user_reqres.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'data/repository/song/song_repository_impl.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'data/sources/song/song_firebase_service.dart';
import 'domain/repository/auth/auth.dart';
import 'domain/repository/song/song.dart';
import 'domain/usecases/auth/signin.dart';
import 'domain/usecases/auth/signup.dart';
import 'domain/usecases/song/get_news_songs.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl(),
  );

  sl.registerSingleton<UserReqresService>(
    UserReqresServiceImpl(),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<SongsRepository>(
    SongRepositoryImpl(),
  );

  sl.registerSingleton<UserReqresRepository>(
    UserReqresRepositoryimpl(),
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(),
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase(),
  );

  sl.registerSingleton<GetNewsSongsUseCase>(
    GetNewsSongsUseCase(),
  );

  sl.registerSingleton<GetPlaylistUseCase>(
    GetPlaylistUseCase(),
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase(),
  );

  sl.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase(),
  );

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase(),
  );

  sl.registerSingleton<GetFavoriteSongsUseCase>(
    GetFavoriteSongsUseCase(),
  );

  sl.registerSingleton<GetUserReqresUseCase>(
    GetUserReqresUseCase(),
  );
}
