import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/core/error/exceptions.dart';
import 'package:xkcd_app/features/search/data/models/comic_model.dart';

abstract class ComicLocalDataSource {
  Future<ComicModel> getCachedComic(int id);
  Future<void> cachComic(ComicModel comicModel, int id);
}

class ComicLocalDataSourceIMpl implements ComicLocalDataSource {
  final SharedPreferences sharedPreferences;

  ComicLocalDataSourceIMpl({required this.sharedPreferences});
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
