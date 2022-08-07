import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/comic_explanation/presentation/provider/comic_explanation_provider.dart';
import 'package:xkcd_app/features/comic_explanation/presentation/widgets/comic_explanation_img.dart';

class ComicEXplanationWidget extends StatefulWidget {
  var item;
  ComicEXplanationWidget({required this.item});

  @override
  State<ComicEXplanationWidget> createState() => _ComicEXplanationWidgetState();
}

class _ComicEXplanationWidgetState extends State<ComicEXplanationWidget> {
  @override
  Widget build(BuildContext context) {
    final String parsedExaplanation =
        Provider.of<ComicExplanationProvider>(context).parsedExaplanation;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Center(
                child: Text(
              widget.item.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            )),
          ),
          ComicExplanationImg(imageUrl: widget.item.img),
          const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 30,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Explanation :",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 20, bottom: 30),
              child: Text(parsedExaplanation)),
        ],
      ),
    );
    ;
  }
}
