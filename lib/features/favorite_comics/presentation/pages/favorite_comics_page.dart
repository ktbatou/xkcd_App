import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/core/provider/favorite_provider.dart';
import 'package:xkcd_app/features/favorite_comics/presentation/provider/Favorite_comics_list.dart';
import 'package:xkcd_app/features/favorite_comics/presentation/widgets/favorite_comic_widget.dart';

class FavoriteComic extends StatefulWidget {
  const FavoriteComic({super.key});

  @override
  State<FavoriteComic> createState() => _FavoriteComicState();
}

class _FavoriteComicState extends State<FavoriteComic> {
  @override
  void initState() {
    setComicList();
    super.initState();
  }

  setComicList() async {
    List<String> favComicsId =
        Provider.of<FavoriteProvider>(context, listen: false).favoredComicsList;
    if (favComicsId.isNotEmpty) {
      await Provider.of<FavoriteComicsList>(context, listen: false)
          .setFavoredComicsList(favComicsId);
    }
  }

  getIconMap(List items) {
    Map<int, dynamic> icons = {};
    if (items.isNotEmpty) {
      for (var i = 0; i < items.length; i++) {
        final iconEnetry = {i: Icons.favorite};
        icons.addAll(iconEnetry);
      }
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    List items = Provider.of<FavoriteComicsList>(context).favoredComics;
    Map<int, dynamic> icons = getIconMap(items);
    return items.isEmpty
        ? const Center(
            child: Text(
              "You have no comics in favorite yet",
              style: TextStyle(color: Colors.black),
            ),
          )
        : Container(
            child: ListView.separated(
                itemBuilder: (context, index) => FavoriteComicWidget(
                      item: items[index],
                      index: index,
                      icons: icons,
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                itemCount: items.length));
  }
}
