import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xkcd_app/features/comics_feed/domain/usecases/get_comics_feed_usecase.dart';
import 'package:xkcd_app/features/comics_feed/presentation/provider/Comic_provider.dart';

class ComicIdProvider extends ChangeNotifier {
  int _comicId = 0;
  final SharedPreferences sharedPreferences;
  final GetComicUseCase getComicUseCase;

  ComicIdProvider(
      {required this.sharedPreferences, required this.getComicUseCase});

  get comicId => _comicId;

  get latestComicId {
    String? id = sharedPreferences.getString("lastComicId");
    if (id != null) {
      return id;
    }
    return "0";
  }

  get updatedId {
    String? id = sharedPreferences.getString("updatedId");
    if (id != null) {
      return id;
    }

    return "0";
  }

  checkComicId() async {
    if (_comicId == 0) {
      final comicModel = await ComicProvider(getComicUseCase: getComicUseCase)
          .comicEntity(0, getComicUseCase);
      if (comicModel != null) {
        _comicId = comicModel.number;
        await sharedPreferences.setString("lastComicId", _comicId.toString());
      }
    }
    notifyListeners();
  }

  void updateComicId(int id) async {
    _comicId = id;
    await sharedPreferences.setString("updatedId", id.toString());
    notifyListeners();
  }
}
