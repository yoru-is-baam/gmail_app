class GetMailsParams {
  final bool? isDraft;
  final bool? isStarred;
  final bool? isInTrash;

  GetMailsParams({
    this.isStarred,
    this.isDraft,
    this.isInTrash,
  });
}
