import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/search/presentation/provider/search_comic_provider.dart';
import 'package:xkcd_app/features/search/presentation/widgets/body.dart';

class SearchComic extends StatefulWidget {
  const SearchComic({super.key});

  @override
  State<SearchComic> createState() => _SearchComicState();
}

class _SearchComicState extends State<SearchComic> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchComicProvider>(context, listen: false).setComic(-1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isbuttonDisable = true;
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
          },
          controller: search,
          keyboardType: TextInputType.number,
          // Only numbers can be entered
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onFieldSubmitted: (val) async {
            if (val.isNotEmpty) {
              await Provider.of<SearchComicProvider>(context, listen: false)
                  .setComic(int.parse(val));
              search.clear();
            }
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search',
          ),
        ),
      ),
      body: const Center(child: bodyWidget()),
    );
  }
}
