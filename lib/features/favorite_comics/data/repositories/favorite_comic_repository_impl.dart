import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/core/error/failures.dart';
import 'package:xkcd_app/features/favorite_comics/domain/entities/favorite_comic_entity.dart';
import 'package:xkcd_app/features/favorite_comics/domain/repositories/favorite_comic_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../datasources/favorite_comic_local_data_source.dart';

class FavoriteComicRepositoryImpl implements FavoriteComicRepository {
  final FavoriteComicLocalDataSource localDataSource;
  final SharedPreferences sharedPreferences;

  FavoriteComicRepositoryImpl(
      {required this.sharedPreferences, required this.localDataSource});
  @override
  Future<Either<Failure, FavoriteComicEntity>> getFavoriteComic(int id) async {
    try {
      final localComic = await localDataSource.getFavoriteComic(id);
      return Right(localComic);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
