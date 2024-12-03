class UpdateMailParams {
  final String mailId;
  final bool? isDraft;
  final bool? isStarred;
  final bool? isInTrash;

  UpdateMailParams({
    required this.mailId,
    this.isStarred,
    this.isDraft,
    this.isInTrash,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (isStarred != null) map["isStarred"] = isStarred;
    if (isDraft != null) map['isDraft'] = isDraft;
    if (isInTrash != null) map['isInTrash'] = isInTrash;

    return map;
  }
}
