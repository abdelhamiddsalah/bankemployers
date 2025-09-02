class Employee {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String nationalID;
  final String pincode;
  final Address address;
  final String dateOfBirth;
  final String jobTitle;
  final String department;
  final String dateOfHiring;
  final String workBranch;
  final String materialStatus;
  final String gender;
  final String role;
  final CVEE cvee;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.nationalID,
    required this.pincode,
    required this.address,
    required this.dateOfBirth,
    required this.jobTitle,
    required this.department,
    required this.dateOfHiring,
    required this.workBranch,
    required this.materialStatus,
    required this.gender,
    required this.role,
    required this.cvee,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      nationalID: json['nationalID'],
      pincode: json['pincode'],
      address: Address.fromJson(json['address']),
      dateOfBirth: json['dateOfBirth'],
      jobTitle: json['jobTitle'],
      department: json['department'],
      dateOfHiring: json['dateOfhiring'], // JSON key small 'h'
      workBranch: json['workBranch'],
      materialStatus: json['materialStatus'],
      gender: json['gender'],
      role: json['role'],
      cvee: CVEE.fromJson(json['cvee']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'nationalID': nationalID,
      'pincode': pincode,
      'address': address.toJson(),
      'dateOfBirth': dateOfBirth,
      'jobTitle': jobTitle,
      'department': department,
      'dateOfhiring': dateOfHiring, // Keep same as JSON
      'workBranch': workBranch,
      'materialStatus': materialStatus,
      'gender': gender,
      'role': role,
      'cvee': cvee.toJson(),
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
