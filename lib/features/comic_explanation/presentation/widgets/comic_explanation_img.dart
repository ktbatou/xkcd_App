import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:skeletons/skeletons.dart';

class ComicExplanationImg extends StatefulWidget {
  String imageUrl;
  ComicExplanationImg({required this.imageUrl});

  @override
  State<ComicExplanationImg> createState() => _ComicExplanationImgState();
}

class _ComicExplanationImgState extends State<ComicExplanationImg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          imageBuilder: (context, imageProvider) {
            return PinchZoom(
              maxScale: 2.5,
              child: Container(
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
                  color: const Color(0xffF5F5F5),
                ),
                child: Container(
                  height: 300,
                  color: const Color(0xffF5F5F5),
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
