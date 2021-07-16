class Allergy {
  final String allergyName;

  Allergy({required this.allergyName});

  factory Allergy.fromMap(Map<String, dynamic> map) => Allergy(
        allergyName: map['allergyName'].toString(),
      );
}
