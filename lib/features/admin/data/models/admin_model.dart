class AdminModel {
  final String email;
  final String password;

  AdminModel({required this.email, required this.password});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
