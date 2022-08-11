import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xkcd_app/features/comics_feed/domain/entities/comics_feed_entity.dart';
import 'package:xkcd_app/features/comics_feed/domain/usecases/get_comics_feed_usecase.dart';
import 'test_helper.mocks.dart';

void main() {
  late MockComicsFeedRepository mockComicsFeedRepository;
  late GetComicUseCase usecase;

  setUp(() {
    mockComicsFeedRepository = MockComicsFeedRepository();
    usecase = GetComicUseCase(mockComicsFeedRepository);
  });

  const int tId = 12;
  const ComicsFeedEntity tComic = ComicsFeedEntity(
      img: "https://en.wikipedia.org/wiki/Cat#/media/File:Cat_poster_1.jpg",
      alt: "alt",
      number: 1,
      title: "title",
      day: "12",
      month: "05",
      year: "2021",
      transcript: "description");

  test('should get the comic from the repository ', () async {
    //arrange
    when(mockComicsFeedRepository.getComic(any))
        .thenAnswer((_) async => const Right(tComic));
    // act
    final result = await usecase.call(tId);
    // assert
    expect(result, const Right(tComic));
    verify(mockComicsFeedRepository.getComic(tId));
  });
}
