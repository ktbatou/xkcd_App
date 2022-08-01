import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  IconData _favoriteIcon = Icons.favorite_border_outlined;
  SharedPreferences sharedPreferences;
  List<String>? favoredComic = [];

  FavoriteProvider({required this.sharedPreferences});

  get favoriteIcon => _favoriteIcon;
  get favoredComicsList {
    List<String>? temp = sharedPreferences.getStringList("favoredComics");
    if (temp != null) {
      return temp;
    } else {
      return <String>[];
    }
  }

  setfavored(int id, IconData icon) async {
    if (sharedPreferences.containsKey("favoredComics")) {
      favoredComic = sharedPreferences.getStringList("favoredComics");
    }
    if (icon == Icons.favorite) {
      if (favoredComic != null) {
        favoredComic!.add(id.toString());
        await sharedPreferences.setStringList("favoredComics", favoredComic!);
      }
      _favoriteIcon = icon;
    } else {
      if (favoredComic != null) {
        favoredComic!.removeWhere((item) => item == id.toString());
        await sharedPreferences.setStringList("favoredComics", favoredComic!);
      }
      _favoriteIcon = icon;
    }
    notifyListeners();
  }
}
