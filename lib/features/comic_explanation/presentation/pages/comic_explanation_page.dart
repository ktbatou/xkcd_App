import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/comic_explanation/presentation/provider/comic_explanation_provider.dart';
import 'package:xkcd_app/features/comic_explanation/presentation/widgets/comic_explanation_widget.dart';

class ComicExplanation extends StatefulWidget {
  var item;
  ComicExplanation({required this.item});

  @override
  State<ComicExplanation> createState() => _ComicExplanationState();
}

class _ComicExplanationState extends State<ComicExplanation> {
  @override
  void initState() {
    setEXplanationText();
    super.initState();
  }

  setEXplanationText() async {
    await Provider.of<ComicExplanationProvider>(context, listen: false)
        .comicExplanationText(widget.item.number, widget.item.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "Xkcd Explanation",
            style: TextStyle(
                fontFamily: 'LSANS',
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                fontSize: 16),
          ),
        ),
        body: ComicEXplanationWidget(
          item: widget.item,
        ));
  }
}
