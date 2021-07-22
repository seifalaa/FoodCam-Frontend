class Allergy {
  final String allergyName;
  final String allergyImageUrl;

  Allergy({required this.allergyImageUrl, required this.allergyName});

  static Allergy fromMap(Map<String, dynamic> map) => Allergy(
        allergyName: map['allergyName'],
        allergyImageUrl: map['allergyImageUrl'],
      );
}
