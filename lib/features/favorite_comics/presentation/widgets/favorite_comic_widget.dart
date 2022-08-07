import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/favorite_comics/presentation/provider/Favorite_comics_list.dart';
import '../../../../core/functions/share_image.dart';
import '../../../../core/provider/NetworkInfoProvider.dart';
import '../../../comics_feed/presentation/widgets/Comic_image.dart';

class FavoriteComicWidget extends StatefulWidget {
  var item;
  int index;
  Map<int, dynamic> icons;
  FavoriteComicWidget(
      {super.key,
      required this.item,
      required this.index,
      required this.icons});

  @override
  State<FavoriteComicWidget> createState() => _FavoriteComicWidgetState();
}

class _FavoriteComicWidgetState extends State<FavoriteComicWidget> {
  IconData favoriteIcon = Icons.favorite;

  @override
  Widget build(BuildContext context) {
    bool isConnected = Provider.of<NetworkInfoProvider>(context).isConnected;
    var item = widget.item;
    var icons = widget.icons;
    int index = widget.index;
    return Container(
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
                              icons[widget.index] =
                                  Icons.favorite_border_outlined;
                              Future.delayed(const Duration(microseconds: 8000),
                                  () {
                                Provider.of<FavoriteComicsList>(context,
                                        listen: false)
                                    .removeComic(context, item.number, index);
                              });
                            }),
                          },
                          icon: Icon(icons[index]),
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
                                  content: const Text("No Internet Connection"),
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
    );
  }
}
