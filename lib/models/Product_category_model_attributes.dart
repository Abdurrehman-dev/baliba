class ProductCategories {
  int id;
  int count;
  String name;
  String description;
  List image;
  String src;
  ProductCategories(
      {this.name, this.count, this.description, this.id, this.image, this.src});

  factory ProductCategories.fromMap(Map<String, dynamic> json) =>
      ProductCategories(
          id: json["id"],
          count: json["count"],
          name: json["name"],
          description: json["description"],
          image: json["image"],
          src: json["src"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "count": count,
        "name": name,
        "description": description,
        "image": image,
        "src": src
      };
}
