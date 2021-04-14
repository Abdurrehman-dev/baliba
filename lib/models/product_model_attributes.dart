class ProductAttributes {
  int id;
  String name;
  String type;
  String status;
  bool featured;
  String description;
  String short_description;
  String price;
  String regular_price;
  String sale_price;
  List images;
  String singleImage;
  String src;
  ProductAttributes(
      {this.id,
      this.name,
      this.type,
      this.status,
      this.featured,
      this.description,
      this.short_description,
      this.price,
      this.singleImage,
      this.regular_price,
      this.sale_price,
      this.images,
      this.src});

  factory ProductAttributes.fromMap(Map<String, dynamic> json) =>
      ProductAttributes(
          id: json["id"],
          name: json["name"],
          type: json["type"],
          status: json["status"],
          featured: json["featured"],
          description: json["description"],
          short_description: json["short_description"],
          price: json["price"],
          regular_price: json["regular_price"],
          sale_price: json["sale_price"],
          images: json["images"],
          singleImage: json["images/src"],
          src: json["src"]);
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "status": status,
        "featured": featured,
        "description": description,
        "short_description": short_description,
        "price": price,
        "regular_price": regular_price,
        "sale_price": sale_price,
        "images": images,
        "src": src
      };
}
