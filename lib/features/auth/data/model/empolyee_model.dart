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
  final String emplyeeID;
  final String jobTitle;
  final String department;
  final String dateOfHiring;
  final String workBranch;
  final String materialStatus;
  final String gender;
  final String role;

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
    required this.emplyeeID,
    required this.jobTitle,
    required this.department,
    required this.dateOfHiring,
    required this.workBranch,
    required this.materialStatus,
    required this.gender,
    required this.role,
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
      emplyeeID: json['emplyeeID'],
      jobTitle: json['jobTitle'],
      department: json['department'],
      dateOfHiring: json['dateOfhiring'],
      workBranch: json['workBranch'],
      materialStatus: json['materialStatus'],
      gender: json['gender'],
      role: json['role'],
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
      'emplyeeID': emplyeeID,
      'jobTitle': jobTitle,
      'department': department,
      'dateOfhiring': dateOfHiring,
      'workBranch': workBranch,
      'materialStatus': materialStatus,
      'gender': gender,
      'role': role,
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
