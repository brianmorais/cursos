class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.type = UserType.PARTICULAR,
    this.createdAt,
  });

  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  UserType type;
  DateTime? createdAt;
}

enum UserType { PARTICULAR, PROFESSIONAL }
