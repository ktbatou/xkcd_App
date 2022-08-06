import 'package:xkcd_app/features/comics_feed/domain/entities/comics_feed_entity.dart';

class ComicModel extends ComicsFeedEntity {
  final String img;
  final String alt;
  final String transcript;
  final int number;
  final String title;
  final String day;
  final String month;
  final String year;
  ComicModel(
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

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
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
