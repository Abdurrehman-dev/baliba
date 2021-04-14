class User {
  int id;
  String email, first_name, last_name, role, username;
  User(
      {this.id,
      this.email,
      this.first_name,
      this.last_name,
      this.role,
      this.username});
  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      email: json["email"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      role: json["role"],
      username: json["username"]);
  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "first_name": first_name,
        "last_name": last_name,
        "role": role,
        "username": username
      };
}
