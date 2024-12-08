class User {
  final int? id;
  final String email;
  final String password;
  final String? userName;
  final String? city;
  final String? phoneNumber;
  final String? imagePath;

  User(
      {this.id,
      required this.email,
      required this.password,
      required this.userName,
      required this.city,
      required this.phoneNumber,
      this.imagePath});

  // Chuyển từ Map (dữ liệu từ SQLite) sang User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      userName: map['userName'],
      city: map['city'],
      phoneNumber: map['phoneNumber'],
      imagePath: map['imagePath'],
    );
  }

  // Chuyển từ User sang Map (để lưu vào SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'userName': userName,
      'city': city,
      'phoneNumber': phoneNumber,
      'imagePath': imagePath,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, password: $password, userName: $userName, city: $city, phoneNumber: $phoneNumber, imagePath: $imagePath}';
  }
}
