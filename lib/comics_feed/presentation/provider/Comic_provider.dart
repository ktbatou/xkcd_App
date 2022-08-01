import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:xkcd_app/comics_feed/data/models/comics_feed_model.dart';
import 'package:xkcd_app/comics_feed/domain/entities/comics_feed_entity.dart';
import 'package:xkcd_app/comics_feed/domain/usecases/get_comics_feed_usecase.dart';
import 'package:xkcd_app/core/error/failures.dart';

class ComicProvider extends ChangeNotifier {
  ComicsFeedEntity? _comicEntity;
  GetComicUseCase getComicUseCase;

  ComicProvider({required this.getComicUseCase});

  get getComicEntity => _comicEntity;

  comicsList(int latestId) async {
    int limitToGet = latestId - 10;
    List<ComicModel> comicList = [];
    for (var i = latestId; i > 0 && i > limitToGet; i--) {
      var comic = await comicEntity(i, getComicUseCase);

      if (comic != null) {
        comicList.add(comic);
      } else {
        return comicList;
      }
    }
    return comicList;
  }

  comicEntity(int id, GetComicUseCase getComicUseCase) async {
    final completer = Completer();

    final result = await getComicUseCase.call(id);

    result.fold((Failure failure) {
      return null;
    }, (data) {
      completer.complete(data);
    });
    return completer.future;
  }
}
