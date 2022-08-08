import 'package:equatable/equatable.dart';

class ComicEntity extends Equatable {
  const ComicEntity(
      {required this.img,
      required this.alt,
      required this.number,
      required this.title,
      required this.day,
      required this.month,
      required this.year,
      required this.transcript});

  final String img;
  final String transcript;
  final String alt;
  final int number;
  final String title;
  final String day;
  final String month;
  final String year;

  @override
  List<Object> get props =>
      [img, alt, number, title, day, month, year, transcript];
}
