import 'package:xkcd_app/features/comic_explanation/domain/entities/comic_explanation_entity.dart';

class ComicExplanationModel extends ComicExplanationEntity {
  final String explanationText;
  ComicExplanationModel({required this.explanationText})
      : super(explanation: explanationText);

  factory ComicExplanationModel.fromJson(Map<String, dynamic> json) {
    return ComicExplanationModel(explanationText: json["parse"]["text"]["*"]);
  }

  @override
  List<Object?> get props => [explanation];
}
