class ShippingProperties {
  String first_name;
  String last_name;
  String company;
  String address_1;
  String address_2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  ShippingProperties(
      {this.first_name,
      this.last_name,
      this.company,
      this.address_1,
      this.address_2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.phone,
      this.email});

  factory ShippingProperties.fromMap(Map<String, dynamic> json) =>
      new ShippingProperties(
        first_name: json["first_name"],
        last_name: json["last_name"],
        company: json["company"],
        address_1: json["address_1"],
        address_2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": first_name,
        "last_name": last_name,
        "company": "",
        "address_1": address_1,
        "address_2": address_2,
        "city": city,
        "state": state,
        "postcode": "",
        "country": "",
        "phone": phone,
        "email": email,
      };
}
