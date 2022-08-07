import 'package:xkcd_app/features/favorite_comics/domain/entities/favorite_comic_entity.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../repositories/favorite_comic_repository.dart';

class FavoriteComicUseCase {
  final FavoriteComicRepository repository;

  FavoriteComicUseCase(this.repository);

  // call method can be run by calling FavoriteComicUseCase.call(id)
  // or just FavoriteComicUseCase(id)
  Future<Either<Failure, FavoriteComicEntity>> call(int id) {
    return repository.getFavoriteComic(id);
  }
}
