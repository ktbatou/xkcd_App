import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart';
import 'package:xkcd_app/features/comic_explanation/domain/usecases/comic_explanation_usecase.dart';
import '../../../../core/error/failures.dart';

class ComicExplanationProvider extends ChangeNotifier {
  String _parsedExaplanation = "";
  String _state = "";
  final ComicExplanationUseCase comicExplanationUseCase;

  ComicExplanationProvider({required this.comicExplanationUseCase});

  get state => _state;
  get parsedExaplanation => _parsedExaplanation;

  comicExplanationText(int id, String title) async {
    _state = "";
    _parsedExaplanation = "";
    final result = await comicExplanationUseCase(id, title);
    result.fold((Failure failure) {
      _state = "error";
      return null;
    }, (data) {
      _state = "hasData";
      _parsedExaplanation = explanationParser(data.explanation);
    });
    notifyListeners();
  }
}

String explanationParser(String explanationText) {
  String parsedExaplanation;

  // remove the string "Explanation[edit]" from the explanation text
  String tmpText = parse(explanationText)
      .documentElement!
      .text
      .replaceRange(0, "Explanation[edit]".length, "")
      .toString();

  // replace every "\n" with "\n\n" and add 2 spaces after ":"
  // so the text become more readable
  tmpText = tmpText.replaceAll("\n", "\n\n").replaceAll(":", ":  ").trim();

  // if the text starts with a caution remove it
  if (tmpText.startsWith("This explanation may be incomplete or incorrect")) {
    int i = tmpText.indexOf("\n");
    tmpText = tmpText.replaceRange(0, i, "");

    // if there is three newlines in the beggining remove the first two newlines
    if (tmpText.startsWith("\n\n\n")) {
      tmpText = tmpText.replaceRange(0, 2, "");
    }
  }
  parsedExaplanation = tmpText;
  return parsedExaplanation;
}
