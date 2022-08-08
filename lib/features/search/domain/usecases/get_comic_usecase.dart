import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/comic_entity.dart';
import '../repositories/comic_repository.dart';

class GetSearchComicUseCase {
  final ComicRepository repository;

  GetSearchComicUseCase(this.repository);

  Future<Either<Failure, ComicEntity>> call(int id) {
    return repository.getComic(id) as Future<Either<Failure, ComicEntity>>;
  }
}
