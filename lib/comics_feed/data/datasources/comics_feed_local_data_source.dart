import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/core/error/exceptions.dart';
import '../models/comics_feed_model.dart';

abstract class ComicsFeedLocalDataSource {
  Future<ComicModel> getCachedComic(int id);
  Future<void> cachComic(ComicModel comicModel, int id);
}

class ComicsFeedLocalDataSourceIMpl implements ComicsFeedLocalDataSource {
  final SharedPreferences sharedPreferences;

  ComicsFeedLocalDataSourceIMpl({required this.sharedPreferences});
  @override
  Future<void> cachComic(ComicModel comicModel, int id) {
    return sharedPreferences.setString(
        id.toString(), json.encode(comicModel.toJoson()));
  }

  @override
  Future<ComicModel> getCachedComic(int id) {
    final comicJson = sharedPreferences.getString(id.toString());

    if (comicJson != null) {
      return Future.value(ComicModel.fromJson(jsonDecode(comicJson)));
    } else {
      throw CacheException();
    }
    ;
  }
}
