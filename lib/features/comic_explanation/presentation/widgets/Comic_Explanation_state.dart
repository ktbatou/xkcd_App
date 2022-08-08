import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/comic_explanation/presentation/provider/comic_explanation_provider.dart';
import 'package:xkcd_app/features/comic_explanation/presentation/widgets/comic_explanation_widget.dart';
import '../../../../core/provider/NetworkInfoProvider.dart';

class Comic_Explanation_state extends StatefulWidget {
  var item;
  Comic_Explanation_state({required this.item});

  @override
  State<Comic_Explanation_state> createState() =>
      _Comic_Explanation_stateState();
}

class _Comic_Explanation_stateState extends State<Comic_Explanation_state> {
  @override
  void initState() {
    super.initState();

    func();
  }

  func() async {
    await Provider.of<ComicExplanationProvider>(context, listen: false)
        .comicExplanationText(widget.item.number, widget.item.title);
  }

  @override
  Widget build(BuildContext context) {
    final String state = Provider.of<ComicExplanationProvider>(context).state;

    bool isConnected =
        Provider.of<NetworkInfoProvider>(context, listen: false).isConnected;
    if (isConnected == true) {
      if (state == "hasData") {
        return ComicEXplanationWidget(item: widget.item);
      } else if (state == "error") {
        return const Center(
            child: Text("Something went wrong! please try again."));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    } else {
      return const Center(child: Text("No internet connection!"));
    }
  }
}
