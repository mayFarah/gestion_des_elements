class Elements {
  int? id;
  String nom;
  String description;
  Elements({this.id, required this.nom, required this.description });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nom": nom,
      "description": description,
    };
  }

  factory Elements.fromMap(Map<String, dynamic> map) {
    return Elements(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
    );
  }
}