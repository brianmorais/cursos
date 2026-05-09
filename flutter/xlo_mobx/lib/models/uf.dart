class Uf {
  Uf({this.id, this.initials, this.name});

  factory Uf.fromJson(Map<String, dynamic> json) => Uf(
        id: json['id'],
        initials: json['sigla'],
        name: json['nome'],
      );

  int? id;
  String? initials;
  String? name;

  @override
  String toString() => 'UF: $id, $initials, $name';
}
