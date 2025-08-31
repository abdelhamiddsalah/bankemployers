class UserInEmployee {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String password;
  final String phoneNumber;
  final String nationalId;
  final DateTime dateOfBirth;
  final String pinCode;
  final AddressUserInEmployee address;
  final String gender;
  final String maritalStatus;
  final dynamic account; // ممكن تبقى null أو Object
  final List<dynamic> deposits; // لحد ما نعرف هي عبارة عن إيه

  UserInEmployee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.password,
    required this.phoneNumber,
    required this.nationalId,
    required this.dateOfBirth,
    required this.pinCode,
    required this.address,
    required this.gender,
    required this.maritalStatus,
    required this.account,
    required this.deposits,
  });

  factory UserInEmployee.fromJson(Map<String, dynamic> json) {
    return UserInEmployee(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      nationalId: json['nationalId'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      pinCode: json['pinCode'],
      address: AddressUserInEmployee.fromJson(json['address']),
      gender: json['gender'],
      maritalStatus: json['maritalStatus'],
      account: json['account'], // null حالياً
      deposits: json['deposits'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'password': password,
      'phoneNumber': phoneNumber,
      'nationalId': nationalId,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'pinCode': pinCode,
      'address': address.toJson(),
      'gender': gender,
      'maritalStatus': maritalStatus,
      'account': account,
      'deposits': deposits,
    };
  }
}

class AddressUserInEmployee {
  final String city;
  final String zipCode;

  AddressUserInEmployee({
    required this.city,
    required this.zipCode,
  });

  factory AddressUserInEmployee.fromJson(Map<String, dynamic> json) {
    return AddressUserInEmployee(
      city: json['city'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'zipCode': zipCode,
    };
  }
}
