import 'package:meta/meta_meta.dart';
import 'package:xkcd_app/features/favorite_comics/domain/entities/favorite_comic_entity.dart';

class FavoriteComicModel extends FavoriteComicEntity {
  FavoriteComicModel(
      {required this.img,
      required this.alt,
      required this.number,
      required this.title,
      required this.day,
      required this.month,
      required this.year,
      required this.transcript})
      : super(
            transcript: transcript,
            img: img,
            alt: alt,
            number: number,
            title: title,
            day: day,
            month: month,
            year: year);

  final String img;
  final String alt;
  final String transcript;
  final int number;
  final String title;
  final String day;
  final String month;
  final String year;

  factory FavoriteComicModel.fromJson(Map<String, dynamic> json) {
    return FavoriteComicModel(
        img: json['img'],
        alt: json['alt'],
        transcript: json['transcript'] != null ? json['transcript'] : "",
        number: (json['num']).toInt(),
        title: json['safe_title'],
        day: json['day'],
        month: json['month'],
        year: json['year']);
  }

  Map<String, dynamic> toJoson() => {
        "img": img,
        "alt": alt,
        "transcript": transcript,
        "num": number,
        "safe_title": title,
        "day": day,
        "month": month,
        "year": year
      };
}
