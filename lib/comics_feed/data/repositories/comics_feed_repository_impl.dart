import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/comics_feed/data/datasources/comics_feed_local_data_source.dart';
import 'package:xkcd_app/comics_feed/data/datasources/comics_feed_remote_data_source.dart';
import 'package:xkcd_app/comics_feed/domain/entities/comics_feed_entity.dart';
import 'package:xkcd_app/comics_feed/domain/repositories/comics_feed_repository.dart';
import 'package:xkcd_app/core/error/exceptions.dart';
import 'package:xkcd_app/core/network/network_info.dart';
import '../../../../core/error/failures.dart';

class ComicsFeedRepositoryImpl implements ComicsFeedRepository {
  final ComicsFeedRemoteDataSource remoteDataSource;
  final ComicsFeedLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  ComicsFeedRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, ComicsFeedEntity>> getComic(int id) async {
    final String idString = id.toString();
    final bool comicIsInCache = sharedPreferences.containsKey(idString);
    // if there is Connection && if the comic is not in cache
    // if yes get the comic from the remote Data Source if there is connection
    if (!comicIsInCache && await networkInfo.isConnected ||
        id == 0 && await networkInfo.isConnected) {
      try {
        final remoteComic = await remoteDataSource.getComic(id);
        localDataSource.cachComic(remoteComic, id);
        return Right(remoteComic);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    // else get the comic from the local Data Source (cache) in case of no connection
    else {
      try {
        final localComic = await localDataSource.getCachedComic(id);
        return Right(localComic);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
