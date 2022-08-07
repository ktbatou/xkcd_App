import 'package:dartz/dartz.dart';
import 'package:xkcd_app/features/comic_explanation/domain/entities/comic_explanation_entity.dart';
import '../../../../core/error/failures.dart';

abstract class ComicExplanationRepository {
  Future<Either<Failure, ComicExplanationEntity>> getComicExplanation(
      int id, String title);
}
