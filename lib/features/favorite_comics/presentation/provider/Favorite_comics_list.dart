import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/features/favorite_comics/domain/entities/favorite_comic_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/provider/favorite_provider.dart';
import '../../domain/usecases/favoriteComicUseCase.dart';

class FavoriteComicsList extends ChangeNotifier {
  List<FavoriteComicEntity> _favoredComics = [];
  final SharedPreferences sharedPreferences;
  final FavoriteComicUseCase favoriteComicUseCase;
  FavoriteComicsList(
      {required this.sharedPreferences, required this.favoriteComicUseCase});

  get favoredComics => _favoredComics;

  setFavoredComicsList(List<String> favoredComicsId) async {
    List<FavoriteComicEntity> _favComicsList = [];

    for (var i = 0; i < favoredComicsId.length; i++) {
      int favComicId = int.parse(favoredComicsId[i]);
      final result = await favoriteComicEntity(favComicId);

      if (result != null) {
        _favComicsList.add(result);
      }
    }
    _favoredComics = _favComicsList;

    notifyListeners();
  }

  removeComic(var context, int id, int index) {
    Provider.of<FavoriteProvider>(context, listen: false)
        .setfavored(id, Icons.favorite_border_outlined);
    _favoredComics.removeAt(index);
    notifyListeners();
  }

  favoriteComicEntity(int id) async {
    final completer = Completer();

    final result = await favoriteComicUseCase.call(id);

    result.fold((Failure failure) {
      return null;
    }, (data) {
      completer.complete(data);
    });
    return completer.future;
  }
}
