import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/core/provider/NetworkInfoProvider.dart';
import 'package:xkcd_app/features/comics_feed/presentation/provider/Comic_Id_provider.dart';
import 'package:xkcd_app/features/comics_feed/presentation/widgets/InfiniteScrollPagination.dart';

class ComicsHome extends StatefulWidget {
  const ComicsHome({super.key});

  @override
  State<ComicsHome> createState() => _ComicsHomeState();
}

class _ComicsHomeState extends State<ComicsHome> {
  bool isConnected = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isConnected = Provider.of<NetworkInfoProvider>(context).isConnected;
    int id = isConnected
        ? Provider.of<ComicIdProvider>(context).comicId
        : int.parse(Provider.of<ComicIdProvider>(context).latestComicId);

    if (id == 0 && isConnected == false) {
      return const Scaffold(
          body: Center(child: Text("No  internet connection")));
    } else if (id == 0 && isConnected == true) {
      return const Scaffold(
          body: Center(
              child: Text(
                  "Please be patient, something intersting is coming ;) ...")));
    } else {
      return Scaffold(
          backgroundColor: const Color(0xffF5F5F5),
          body: InifinteScrollPagination(
            id: id,
          ));
    }
  }
}
