import 'package:dartz/dartz.dart';
import 'package:xkcd_app/features/favorite_comics/domain/entities/favorite_comic_entity.dart';
import '../../../../core/error/failures.dart';

abstract class FavoriteComicRepository {
  Future<Either<Failure, FavoriteComicEntity>> getFavoriteComic(int id);
}
