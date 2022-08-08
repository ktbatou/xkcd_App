import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/core/error/exceptions.dart';
import 'package:xkcd_app/core/network/network_info.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/comic_entity.dart';
import '../../domain/repositories/comic_repository.dart';
import '../datasources/comic_local_data_source.dart';
import '../datasources/comic_remote_data_source.dart';

class ComicRepositoryImpl implements ComicRepository {
  final ComicRemoteDataSource remoteDataSource;
  final ComicLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  ComicRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, ComicEntity>> getComic(int id) async {
    final String idString = id.toString();
    final bool comicIsInCache = sharedPreferences.containsKey(idString);
    // if there is Connection && if the comic is not in cache
    // get the comic from the remote Data Source
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
