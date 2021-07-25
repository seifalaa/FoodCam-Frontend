class Collection {
  final int id;
  final String collectionName;
  final int recipeCount;
  final String collectionImageUrl;
  final int userId;

  const Collection(
      {required this.id,
      required this.userId,
      required this.collectionImageUrl,
      required this.collectionName,
      required this.recipeCount});

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'],
      userId: map['user'],
      collectionName: map['collection_name'],
      recipeCount: map['recipes'],
      collectionImageUrl: map['collection_image'],
    );
  }
}
