import 'package:dartz/dartz.dart';
import 'package:xkcd_app/core/error/failures.dart';
import 'package:xkcd_app/features/comic_explanation/data/datasources/comic_explanation_remote_data_source.dart';
import 'package:xkcd_app/features/comic_explanation/domain/entities/comic_explanation_entity.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/comic_explanation_repository.dart';

class ComicExplanationRepositoryImpl implements ComicExplanationRepository {
  final ComicExplanationRemoteDataSource remoteDataSource;
  ComicExplanationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ComicExplanationEntity>> getComicExplanation(
      int id, String title) async {
    try {
      final remoteComicExplanation =
          await remoteDataSource.getComicExplanation(id, title);
      return Right(remoteComicExplanation);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
