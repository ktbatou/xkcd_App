import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xkcd_app/features/comics_feed/data/models/comics_feed_model.dart';
import 'package:xkcd_app/features/comics_feed/domain/entities/comics_feed_entity.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  final tComicModel = ComicModel(
      img: "https://imgs.xkcd.com/comics/trained_a_neural_net.png",
      alt: "alt",
      number: 1,
      title: "title",
      day: "12",
      month: "05",
      year: "2021",
      transcript: "description");

  test(
    'should be a subclass of Comic entity',
    () async {
      // assert

      expect(tComicModel, isA<ComicsFeedEntity>());
    },
  );
// Does the fromJson() function return a valid model?

  group('from json', () {
    test('should return a valid model from json', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('comic.json'));
      final result = ComicModel.fromJson(jsonMap);
      expect(result, tComicModel);
    });
  });
// Does the toJson() function returns the appropriate JSON map?

  group('toJson', () {
    test('should return a json map containing proper data', () async {
      final result = tComicModel.toJoson();
      final expectedJsonMap = {
        "img": "https://imgs.xkcd.com/comics/trained_a_neural_net.png",
        "alt": "alt",
        "num": 1,
        "safe_title": "title",
        "day": "12",
        "month": "05",
        "year": "2021",
        "transcript": "description"
      };

      expect(result, expectedJsonMap);
    });
  });
}
