import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xkcd_app/features/comics_feed/data/datasources/comics_feed_remote_data_source.dart';
import 'package:xkcd_app/features/comics_feed/data/models/comics_feed_model.dart';
import '../../../../core/fixtures/fixture_reader.dart';
import 'test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late ComicsFeedRemoteDataSourceIMpl datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = ComicsFeedRemoteDataSourceIMpl(client: mockHttpClient);
  });

  group('get comic succesfully', () {
    int tId = 1;
    final tComicModel =
        ComicModel.fromJson(json.decode(fixture('current_comic.json')));

    test('should return Comic model when the response code is 200', () async {
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(fixture('current_comic.json'), 200));
      final result = await datasource.getComic(tId);
      expect(result, tComicModel);
    });
  });
}
