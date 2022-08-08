import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xkcd_app/core/error/exceptions.dart';
import 'package:xkcd_app/features/search/data/models/comic_model.dart';

abstract class ComicRemoteDataSource {
  Future<ComicModel> getComic(int id);
}

class ComicRemoteDataSourceIMpl implements ComicRemoteDataSource {
  @override
  Future<ComicModel> getComic(int id) {
    return _getComicFromUrl('https://xkcd.com/${id.toString()}/info.0.json');
  }

  Future<ComicModel> _getComicFromUrl(String urlString) async {
    Uri url = Uri.parse(urlString);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ComicModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
