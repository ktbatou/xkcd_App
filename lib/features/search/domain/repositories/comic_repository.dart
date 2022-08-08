import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/comic_entity.dart';

abstract class ComicRepository {
  Future<Either<Failure, ComicEntity>> getComic(int id);
}
