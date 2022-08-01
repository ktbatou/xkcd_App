import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xkcd_app/comics_feed/data/models/comics_feed_model.dart';
import 'package:xkcd_app/core/error/exceptions.dart';

abstract class ComicsFeedRemoteDataSource {
  Future<ComicModel> getComic(int id);
}

class ComicsFeedRemoteDataSourceIMpl implements ComicsFeedRemoteDataSource {
  @override
  Future<ComicModel> getComic(int id) {
    // if the id is default i get the current Comic with the current Comic endpoint,
    // so i can get the lastest comic's id to start with
    if (id == 0) {
      return _getComicFromUrl('https://xkcd.com/info.0.json');
      // else i get the comic with the given id
    } else {
      return _getComicFromUrl('https://xkcd.com/${id.toString()}/info.0.json');
    }
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
