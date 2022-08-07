import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/comic_explanation/presentation/pages/comic_explanation_page.dart';
import 'package:xkcd_app/features/comics_feed/presentation/widgets/Comic_image.dart';
import 'package:xkcd_app/core/functions/share_image.dart';
import 'package:xkcd_app/core/provider/favorite_provider.dart';
import '../../../../../core/provider/NetworkInfoProvider.dart';

class ComicWidget extends StatefulWidget {
  var item;
  ComicWidget({super.key, required this.item});

  @override
  State<ComicWidget> createState() => _ComicWidgetState();
}

class _ComicWidgetState extends State<ComicWidget> {
  IconData favoriteIcon = Icons.favorite_border_outlined;
  @override
  void initState() {
    checkFavoredComic();
    super.initState();
  }

  checkFavoredComic() {
    List<String>? favoredList =
        Provider.of<FavoriteProvider>(context, listen: false).favoredComicsList;
    if (favoredList != null) {
      bool exist = favoredList.contains(widget.item.number.toString());

      if (exist) {
        favoriteIcon = Icons.favorite;
      }
    } else {
      favoriteIcon = Icons.favorite_border_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isConnected =
        Provider.of<NetworkInfoProvider>(context, listen: false).isConnected;
    var item = widget.item;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ComicExplanation(
                    item: item,
                  )),
        );
      },
      child: Container(
        width: 400,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                child: Text(
                  item.title,
                  style: const TextStyle(
                      fontFamily: 'LSANS', fontWeight: FontWeight.w800),
                ),
              ),
            ),
            ComicImage(imageUrl: item.img),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: IconButton(
                            onPressed: () => {
                              setState(() {
                                if (favoriteIcon == Icons.favorite) {
                                  favoriteIcon = Icons.favorite_border_outlined;
                                  Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .setfavored(item.number,
                                          Icons.favorite_border_outlined);
                                } else {
                                  favoriteIcon = Icons.favorite;
                                  Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .setfavored(item.number, Icons.favorite);
                                }
                              })
                            },
                            icon: Icon(favoriteIcon),
                          )),
                      IconButton(
                        padding: const EdgeInsets.only(right: 24),
                        onPressed: () async {
                          if (isConnected) {
                            shareImage(item.img, item.title, item.number);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("You can't Share"),
                                    content:
                                        const Text("No Internet Connection"),
                                    actions: [
                                      TextButton(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.of(context).pop()),
                                    ],
                                  );
                                });
                          }
                        },
                        icon: const Icon(Icons.share),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(item.number.toString())),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.centerLeft,
                child: item.transcript != ""
                    ? Text(
                        item.transcript,
                        style: const TextStyle(fontFamily: 'Inter'),
                      )
                    : Text(
                        item.alt,
                        style: const TextStyle(fontFamily: 'Inter'),
                      )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
              child: Container(
                  padding: const EdgeInsets.only(left: 7),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " ${item.day}/${item.month}/${item.year} ",
                    style: const TextStyle(color: Color(0xffADABAB)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
