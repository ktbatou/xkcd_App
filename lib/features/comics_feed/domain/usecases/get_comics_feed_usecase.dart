import 'package:xkcd_app/features/comics_feed/domain/entities/comics_feed_entity.dart';
import 'package:xkcd_app/features/comics_feed/domain/repositories/comics_feed_repository.dart';

import '../../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetComicUseCase {
  final ComicsFeedRepository repository;

  GetComicUseCase(this.repository);

  // call method can be run by calling GetComicUseCase.call(id)
  // or just GetComicUseCase(id)
  Future<Either<Failure, ComicsFeedEntity>> call(int id) {
    return repository.getComic(id) as Future<Either<Failure, ComicsFeedEntity>>;
  }
}
