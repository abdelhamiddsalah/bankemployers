class EmployersModel {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String password;
  final String? phoneNumber;
  final String? nationalID;
  final Address? address;
  final DateTime? dateOfBirth;
  final String? emplyeeID;
  final DateTime? dateOfHiring;
  final String role;
  final List<dynamic> pdfFile;
  final List<dynamic>? users; // Made nullable since it's not in your JSON
  final String pincode;
  final String? jobTitle;
  final String? department;
  final String? materialStatus;
  final String? workBranch;
  final String? gender;

  EmployersModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    required this.password,
    this.phoneNumber,
    this.nationalID,
    this.address,
    this.dateOfBirth,
    this.emplyeeID,
    this.dateOfHiring,
    required this.role,
    required this.pdfFile,
    this.users,
    required this.pincode,
    this.jobTitle,
    this.department,
    this.materialStatus,
    this.workBranch,
    this.gender,
  });

  factory EmployersModel.fromJson(Map<String, dynamic> json) {
    return EmployersModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      nationalID: json['nationalID'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      dateOfBirth: json['dateOfBirth'] != null 
          ? DateTime.parse(json['dateOfBirth']) 
          : null,
      emplyeeID: json['emplyeeID'],
      dateOfHiring: json['dateOfhiring'] != null 
          ? DateTime.parse(json['dateOfhiring']) 
          : null,
      role: json['role'],
      pdfFile: json['pdfFile'] != null 
          ? List<dynamic>.from(json['pdfFile']) 
          : [],
      users: json['users'] != null 
          ? List<dynamic>.from(json['users']) 
          : null,
      pincode: json['pincode'],
      jobTitle: json['jobTitle'],
      department: json['department'],
      materialStatus: json['materialStatus'],
      workBranch: json['workBranch'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'nationalID': nationalID,
      'address': address?.toJson(),
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'emplyeeID': emplyeeID,
      'dateOfhiring': dateOfHiring?.toIso8601String(),
      'role': role,
      'pdfFile': pdfFile,
      'users': users,
      'pincode': pincode,
      'jobTitle': jobTitle,
      'department': department,
      'materialStatus': materialStatus,
      'workBranch': workBranch,
      'gender': gender,
    };
  }
}

class Address {
  final String city;
  final String zipCode;

  Address({required this.city, required this.zipCode});

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