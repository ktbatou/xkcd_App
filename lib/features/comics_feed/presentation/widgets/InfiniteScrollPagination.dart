import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/comics_feed/domain/entities/comics_feed_entity.dart';
import 'package:xkcd_app/features/comics_feed/presentation/provider/Comic_provider.dart';
import 'package:xkcd_app/features/comics_feed/presentation/widgets/Comic_Widget.dart';

class InifinteScrollPagination extends StatefulWidget {
  int id;
  InifinteScrollPagination({super.key, required this.id});

  @override
  State<InifinteScrollPagination> createState() =>
      _InifinteScrollPaginationState();
}

class _InifinteScrollPaginationState extends State<InifinteScrollPagination> {
  late final PagingController<int, ComicsFeedEntity> _pagingController;
  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: widget.id);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<ComicsFeedEntity> newItems =
          await Provider.of<ComicProvider>(context, listen: false)
              .comicsList(pageKey);
      print(newItems);
      if (newItems.length < 10) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey - newItems.length;

        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, ComicsFeedEntity>.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<ComicsFeedEntity>(
          itemBuilder: (context, item, index) {
        return ComicWidget(item: item);
      }),
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}
