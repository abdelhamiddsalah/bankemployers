class Employee {
  final User user;
  final String jobTitle;
  final String department;
  final String dateOfHiring;
  final String workBranch;
  final CVEE cvee;

  Employee({
    required this.user,
    required this.jobTitle,
    required this.department,
    required this.dateOfHiring,
    required this.workBranch,
    required this.cvee,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      user: User.fromJson(json['user']),
      jobTitle: json['jobTitle'],
      department: json['department'],
      dateOfHiring: json['dateOfHiring'],
      workBranch: json['workBranch'],
      cvee: CVEE.fromJson(json['cvee']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'jobTitle': jobTitle,
      'department': department,
      'dateOfHiring': dateOfHiring,
      'workBranch': workBranch,
      'cvee': cvee.toJson(),
    };
  }
}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String nationalId;
  final String pinCode;
  final Address address;
  final String dateOfBirth;
  final String maritalStatus;
  final String gender;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.nationalId,
    required this.pinCode,
    required this.address,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      nationalId: json['nationalId'],
      pinCode: json['pinCode'],
      address: Address.fromJson(json['address']),
      dateOfBirth: json['dateOfBirth'],
      maritalStatus: json['maritalStatus'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'nationalId': nationalId,
      'pinCode': pinCode,
      'address': address.toJson(),
      'dateOfBirth': dateOfBirth,
      'maritalStatus': maritalStatus,
      'gender': gender,
    };
  }
}

class Address {
  final String city;
  final String zipCode;

  Address({
    required this.city,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
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

class CVEE {
  final String copoun;

  CVEE({
    required this.copoun,
  });

  factory CVEE.fromJson(Map<String, dynamic> json) {
    return CVEE(
      copoun: json['copoun'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'copoun': copoun,
    };
  }
}
