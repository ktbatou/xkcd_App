import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/features/comic_explanation/data/datasources/comic_explanation_remote_data_source.dart';
import 'package:xkcd_app/features/comic_explanation/domain/repositories/comic_explanation_repository.dart';
import 'package:xkcd_app/features/comic_explanation/domain/usecases/comic_explanation_usecase.dart';
import 'package:xkcd_app/features/comics_feed/data/datasources/comics_feed_local_data_source.dart';
import 'package:xkcd_app/features/comics_feed/data/datasources/comics_feed_remote_data_source.dart';
import 'package:xkcd_app/features/comics_feed/domain/usecases/get_comics_feed_usecase.dart';
import 'package:xkcd_app/features/comics_feed/presentation/provider/Comic_Id_provider.dart';
import 'package:xkcd_app/features/comics_feed/presentation/provider/Comic_provider.dart';
import 'package:xkcd_app/core/network/network_info.dart';
import 'package:xkcd_app/core/provider/NetworkInfoProvider.dart';
import 'package:xkcd_app/core/provider/favorite_provider.dart';
import 'package:xkcd_app/features/favorite_comics/data/datasources/favorite_comic_local_data_source.dart';
import 'package:xkcd_app/features/favorite_comics/data/repositories/favorite_comic_repository_impl.dart';
import 'package:xkcd_app/features/favorite_comics/domain/repositories/favorite_comic_repository.dart';
import 'package:xkcd_app/features/favorite_comics/domain/usecases/favoriteComicUseCase.dart';
import 'package:xkcd_app/features/favorite_comics/presentation/provider/Favorite_comics_list.dart';
import 'features/comic_explanation/data/repositories/comic_explanation_repositoryImpl.dart';
import 'features/comic_explanation/presentation/provider/comic_explanation_provider.dart';
import 'features/comics_feed/data/repositories/comics_feed_repository_impl.dart';
import 'features/comics_feed/domain/repositories/comics_feed_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //! Feature : comics_feed

  // provider
  /// comic  data provider
  serviceLocator.registerFactory<ComicProvider>(
      () => ComicProvider(getComicUseCase: serviceLocator()));

  /// comic id provider
  serviceLocator.registerFactory<ComicIdProvider>(() => ComicIdProvider(
      sharedPreferences: serviceLocator(), getComicUseCase: serviceLocator()));

  // useCase

  /// get comic UseCase (comic_feed)
  serviceLocator.registerLazySingleton(() => GetComicUseCase(serviceLocator()));

  // repository
  serviceLocator.registerLazySingleton<ComicsFeedRepository>(() =>
      ComicsFeedRepositoryImpl(
          remoteDataSource: serviceLocator(),
          localDataSource: serviceLocator(),
          sharedPreferences: serviceLocator(),
          networkInfo: serviceLocator()));

  // data source
  /// remoteDataSource
  serviceLocator.registerLazySingleton<ComicsFeedRemoteDataSource>(
      () => ComicsFeedRemoteDataSourceIMpl(client: serviceLocator()));

  /// LocalDataSource
  serviceLocator.registerLazySingleton<ComicsFeedLocalDataSource>(
      () => ComicsFeedLocalDataSourceIMpl(sharedPreferences: serviceLocator()));

  // =================================== ********** =======================================

  //! features : favorite comic

  // provider

  /// favorite List Provider
  serviceLocator.registerFactory(() => FavoriteComicsList(
      sharedPreferences: serviceLocator(),
      favoriteComicUseCase: serviceLocator()));
  // Usecase

  /// Favorite Comic UseCase
  serviceLocator
      .registerLazySingleton(() => FavoriteComicUseCase(serviceLocator()));
  // Repository
  serviceLocator.registerLazySingleton<FavoriteComicRepository>(() =>
      FavoriteComicRepositoryImpl(
          sharedPreferences: serviceLocator(),
          localDataSource: serviceLocator()));
  // data source
  /// localDataSource
  serviceLocator.registerLazySingleton<FavoriteComicLocalDataSource>(() =>
      FavoriteComicLocalDataSourceImpl(sharedPreferences: serviceLocator()));

  // =================================== ********** =======================================

  // ! features : Comic explanation

  //  provider
  serviceLocator.registerFactory<ComicExplanationProvider>(() =>
      ComicExplanationProvider(comicExplanationUseCase: serviceLocator()));

  // UseCase
  serviceLocator
      .registerLazySingleton(() => ComicExplanationUseCase(serviceLocator()));

  // repository
  serviceLocator.registerLazySingleton<ComicExplanationRepository>(
      () => ComicExplanationRepositoryImpl(remoteDataSource: serviceLocator()));
  // dataSource
  /// remoteDataSource
  serviceLocator.registerLazySingleton<ComicExplanationRemoteDataSource>(
      () => ComicExplanationRemoteDataSourceIMpl());

  // =================================== ********** =======================================

  //! core

  //provider
  /// NetworkInfo Provider
  serviceLocator.registerFactory<NetworkInfoProvider>(
      () => NetworkInfoProvider(networkInfo: serviceLocator()));

  /// favorite provider
  serviceLocator.registerFactory<FavoriteProvider>(
      () => FavoriteProvider(sharedPreferences: serviceLocator()));

  //networkInfo
  serviceLocator.registerFactory<NetworkInfo>(() => NetworkInfoImpl());

  //sharedPrefernces

  serviceLocator.registerFactory<SharedPreferences>(() => sharedPreferences);

  //http Client
  serviceLocator.registerLazySingleton(() => http.Client());
  // =================================== ********** =======================================
}
