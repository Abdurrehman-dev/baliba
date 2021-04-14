class LineItems {
  int id, quantity;

  LineItems({this.quantity, this.id});

  factory LineItems.fromMap(Map<String, dynamic> json) => LineItems(
        id: json["id"],
        quantity: json["quantity"],
      );
  Map<String, dynamic> toMap() => {
        "product_id": id,
        "quantity": quantity,
      };
}
