import 'package:dartz/dartz.dart';
import 'package:xkcd_app/core/error/failures.dart';
import 'package:xkcd_app/features/comic_explanation/domain/entities/comic_explanation_entity.dart';

import '../repositories/comic_explanation_repository.dart';

class ComicExplanationUseCase {
  final ComicExplanationRepository repository;

  ComicExplanationUseCase(this.repository);

  // call method can be run by calling ComicExplanationUseCase.call(id, title)
  // or just ComicExplanationUseCase(id, title)
  Future<Either<Failure, ComicExplanationEntity>> call(int id, String title) {
    return repository.getComicExplanation(id, title);
  }
}
