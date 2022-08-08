import 'package:flutter/cupertino.dart';
import 'package:xkcd_app/core/error/failures.dart';
import 'package:xkcd_app/features/search/domain/usecases/get_comic_usecase.dart';

class SearchComicProvider extends ChangeNotifier {
  var _comic;
  String _state = "";
  final GetSearchComicUseCase comicUseCase;

  SearchComicProvider({required this.comicUseCase});

  get state => _state;
  get comicData => _comic;

  setComic(int id) async {
    if (id == -1) {
      _state = "";
    } else {
      _state = "loading";
      final result = await comicUseCase(id);

      result.fold((Failure failure) {
        _state = "error";
        return null;
      }, (data) {
        _state = "hasData";
        _comic = data;
      });
    }
    notifyListeners();
  }
}
