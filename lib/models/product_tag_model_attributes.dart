class ProductTagAttributes {
  int id;
  String name;
  String description;
  ProductTagAttributes({this.description, this.name, this.id});

  factory ProductTagAttributes.fromMap(Map<String, dynamic> json) =>
      ProductTagAttributes(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
