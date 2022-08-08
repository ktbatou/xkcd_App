import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/search/presentation/widgets/comic_widget.dart';
import '../provider/search_comic_provider.dart';

class bodyWidget extends StatefulWidget {
  const bodyWidget({super.key});

  @override
  State<bodyWidget> createState() => _bodyWidgetState();
}

class _bodyWidgetState extends State<bodyWidget> {
  @override
  Widget build(BuildContext context) {
    String state = Provider.of<SearchComicProvider>(context).state;
    var comicData = Provider.of<SearchComicProvider>(context).comicData;
    if (state == "hasData") {
      return ComicWidget(comicData: comicData);
    } else if (state == "error") {
      return const Center(
        child: Text("error occurred while searching for this comic"),
      );
    } else if (state == "loading") {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center(
        child: Text("Search for a comic by his number."),
      );
    }
  }
}
