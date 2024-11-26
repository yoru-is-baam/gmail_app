import 'package:equatable/equatable.dart';

class LabelEntity extends Equatable {
  final String? id;
  final String name;
  final String color;

  const LabelEntity({
    required this.id,
    required this.name,
    required this.color,
  });

  @override
  List<Object?> get props => [id, name, color];
}
