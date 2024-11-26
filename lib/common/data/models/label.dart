import 'package:gmail_app/common/domain/entities/label.dart';

class LabelModel extends LabelEntity {
  final String userId;

  const LabelModel({
    required super.id,
    required super.name,
    required super.color,
    required this.userId,
  });

  factory LabelModel.fromMap(Map<String, dynamic> map) {
    return LabelModel(
      id: map["id"],
      name: map["name"],
      color: map["color"],
      userId: map["userId"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "color": color,
      "userId": userId,
    };
  }

  factory LabelModel.fromEntity(LabelEntity entity, String userId) {
    return LabelModel(
      id: entity.id,
      name: entity.name,
      color: entity.color,
      userId: userId,
    );
  }
}
