import 'package:dartz/dartz.dart';
import 'package:xkcd_app/comics_feed/domain/entities/comics_feed_entity.dart';
import '../../../../core/error/failures.dart';

abstract class ComicsFeedRepository {
  Future<Either<Failure, ComicsFeedEntity>> getComic(int id);
}
