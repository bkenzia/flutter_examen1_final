class Departement {
  final String nom;
  final String code;
  final String codeRegion;
  final String? score;

  Departement(this.nom, this.code, this.codeRegion, this.score);

  factory Departement.fromJson(Map<String, dynamic> json) {
    return Departement(
        json['nom'], json['code'], json['codeRegion'], json['_score']);
  }
//ou cas vous auriez besoin de geteurs,

  String get getNom => nom;
  String get getCode => code;
  String get getCodeRegion => codeRegion;
  String? get getScore => score;
}

class DepartementList {
  final List<Departement> departements;
  DepartementList({required this.departements});

  factory DepartementList.fromJson(List<dynamic> parseJson) {
    List<Departement> departements = <Departement>[];
    departements = parseJson.map((p) => Departement.fromJson(p)).toList();
    return DepartementList(departements: departements);
  }
}
