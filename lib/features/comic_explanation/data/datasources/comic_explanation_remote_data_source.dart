import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

import '../models/comic_explanation_model.dart';

abstract class ComicExplanationRemoteDataSource {
  Future<ComicExplanationModel> getComicExplanation(int id, String title);
}

class ComicExplanationRemoteDataSourceIMpl
    implements ComicExplanationRemoteDataSource {
  @override
  Future<ComicExplanationModel> getComicExplanation(
      int id, String title) async {
    // params of the xkcd explanation endPoint
    final params = {
      "action": "parse",
      "page": "$id: $title",
      "prop": "text",
      "section": "1",
      "sectiontitle": "Explanation",
      "format": "json",
    };
    final url = Uri.https("explainxkcd.com", "/wiki/api.php", params);
    return _getComicFromUrl(url);
  }

  Future<ComicExplanationModel> _getComicFromUrl(Uri url) async {
    final response = await http.get(url);
    // after a get request, check the status code if 200 (got data successfuly)
    // return the model
    // otherwise throw a serverException
    if (response.statusCode == 200) {
      return ComicExplanationModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
