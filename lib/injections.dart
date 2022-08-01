import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/comics_feed/data/datasources/comics_feed_local_data_source.dart';
import 'package:xkcd_app/comics_feed/data/datasources/comics_feed_remote_data_source.dart';
import 'package:xkcd_app/comics_feed/domain/usecases/get_comics_feed_usecase.dart';
import 'package:xkcd_app/comics_feed/presentation/provider/Comic_provider.dart';
import 'package:xkcd_app/core/network/network_info.dart';
import 'package:xkcd_app/core/provider/NetworkInfoProvider.dart';
import 'package:xkcd_app/core/provider/favorite_provider.dart';
import 'comics_feed/data/repositories/comics_feed_repository_impl.dart';
import 'comics_feed/domain/repositories/comics_feed_repository.dart';
import 'comics_feed/presentation/provider/Comic_Id_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      () => ComicsFeedRemoteDataSourceIMpl());

  /// LocalDataSource
  serviceLocator.registerLazySingleton<ComicsFeedLocalDataSource>(
      () => ComicsFeedLocalDataSourceIMpl(sharedPreferences: serviceLocator()));

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
  // =================================== ********** =======================================
}
