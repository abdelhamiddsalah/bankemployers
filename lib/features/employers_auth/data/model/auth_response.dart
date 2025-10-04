class AuthResponse {
  final String token;
  final String role;

  AuthResponse({
    required this.token,
    required this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'role': role,
    };
  }
}
