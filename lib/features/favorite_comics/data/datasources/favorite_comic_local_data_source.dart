import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/favorite_comic_model.dart';

abstract class FavoriteComicLocalDataSource {
  Future<FavoriteComicModel> getFavoriteComic(int id);
}

class FavoriteComicLocalDataSourceImpl implements FavoriteComicLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoriteComicLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<FavoriteComicModel> getFavoriteComic(int id) {
    final comicJson = sharedPreferences.getString(id.toString());
    if (comicJson != null) {
      return Future.value(FavoriteComicModel.fromJson(jsonDecode(comicJson)));
    } else {
      throw CacheException();
    }
    ;
  }
}
