import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

shareImage(String img, String title, int number) async {
  var imageurl = img;
  String id = number.toString();
  final uri = Uri.parse(imageurl);
  final response = await http.get(uri);
  final bytes = response.bodyBytes;

  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/image.jpg';

  File(path).writeAsBytesSync(bytes);

  await Share.shareFiles([path], text: "$number: $title");
}
