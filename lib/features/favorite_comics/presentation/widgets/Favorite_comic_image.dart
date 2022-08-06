import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:skeletons/skeletons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoriteComicImage extends StatefulWidget {
  String imageUrl;
  FavoriteComicImage({super.key, required this.imageUrl});

  @override
  State<FavoriteComicImage> createState() => _FavoriteComicImage();
}

class _FavoriteComicImage extends State<FavoriteComicImage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: 300,
      child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) {
            return PinchZoom(
              // maxScale: 2.5,
              child: Container(
                  // height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ))),
            );
          },
          progressIndicatorBuilder: (context, url, progress) => Skeleton(
                isLoading: true,
                skeleton: Container(
                  color: Color(0xffF5F5F5),
                ),
                child: Container(
                  height: 300,
                  color: Color(0xffF5F5F5),
                ),
              ),
          errorWidget: (context, url, error) {
            return Image.asset(
              "assets/image/offline.jpg",
              width: 300,
              height: 300,
            );
          }),
    );
  }
}
