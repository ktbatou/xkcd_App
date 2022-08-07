import 'package:equatable/equatable.dart';

class ComicExplanationEntity extends Equatable {
  final String explanation;
  const ComicExplanationEntity({required this.explanation});

  @override
  List<Object?> get props => [explanation];
}
