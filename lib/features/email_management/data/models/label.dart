import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmail_app/core/session_manager.dart';
import 'package:gmail_app/features/email_management/domain/entities/label.dart';

class LabelModel extends LabelEntity {
  final String userId;

  const LabelModel({
    super.id,
    required super.name,
    required super.color,
    required this.userId,
  });

  factory LabelModel.fromDocument(DocumentSnapshot doc) {
    var map = doc.data() as Map<String, dynamic>;

    return LabelModel(
      id: doc.id,
      name: map['name'],
      color: map['color'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
      'userId': userId,
    };
  }

  factory LabelModel.fromEntity(
    LabelEntity entity,
  ) {
    return LabelModel(
      id: entity.id,
      name: entity.name,
      color: entity.color,
      userId: SessionManager.currentUserId!,
    );
  }
}
