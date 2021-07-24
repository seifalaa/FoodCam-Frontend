class Allergy {
  final String allergyName;
  final String allergyImageUrl;
  final int allergyId;

  Allergy({
    required this.allergyImageUrl,
    required this.allergyName,
    required this.allergyId,
  });

  factory Allergy.fromMap(Map<String, dynamic> map) => Allergy(
        allergyName: map['allergy_type'],
        allergyImageUrl: map['image'],
        allergyId: map['allergy'],
      );
  factory Allergy.fromMapAllAllergies(Map<String, dynamic> map) => Allergy(
        allergyName: map['allergy_type'],
        allergyImageUrl: '',
        allergyId: map['allergy'],
      );
}
