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
  final Address address;
  final String? gender;          // <-- nullable
  final String? maritalStatus;   // <-- nullable
  final AccountInEmployee? account;
  final List<DepositInEmployee> deposits;

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
    this.gender,               // nullable
    this.maritalStatus,        // nullable
    this.account,
    required this.deposits,
  });

  factory UserInEmployee.fromJson(Map<String, dynamic> json) {
    return UserInEmployee(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      role: json["role"],
      password: json["password"],
      phoneNumber: json["phoneNumber"],
      nationalId: json["nationalId"],
      dateOfBirth: DateTime.parse(json["dateOfBirth"]),
      pinCode: json["pinCode"],
      address: Address.fromJson(json["address"]),
      gender: json["gender"],                   // ممكن يكون null
      maritalStatus: json["maritalStatus"],    // ممكن يكون null
      account: json["account"] != null
          ? AccountInEmployee.fromJson(json["account"])
          : null,
      deposits: (json["deposits"] as List)
          .map((d) => DepositInEmployee.fromJson(d))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "role": role,
      "password": password,
      "phoneNumber": phoneNumber,
      "nationalId": nationalId,
      "dateOfBirth": dateOfBirth.toIso8601String(),
      "pinCode": pinCode,
      "address": address.toJson(),
      "gender": gender,
      "maritalStatus": maritalStatus,
      "account": account?.toJson(),
      "deposits": deposits.map((d) => d.toJson()).toList(),
    };
  }
}

class Address {
  final String city;
  final String zipCode;

  Address({required this.city, required this.zipCode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json["city"],
      zipCode: json["zipCode"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "zipCode": zipCode,
    };
  }
}

class AccountInEmployee {
  final int id;
  final String accountType;
  final String accountNumber;
  final double balance;
  final DateTime createdAt;

  AccountInEmployee({
    required this.id,
    required this.accountType,
    required this.accountNumber,
    required this.balance,
    required this.createdAt,
  });

  factory AccountInEmployee.fromJson(Map<String, dynamic> json) {
    return AccountInEmployee(
      id: json["id"],
      accountType: json["accountType"],
      accountNumber: json["accountNumber"],
      balance: (json["balance"] as num).toDouble(),
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "accountType": accountType,
      "accountNumber": accountNumber,
      "balance": balance,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}

class DepositInEmployee {
  final int depositId;
  final double amount;
  final DateTime date;
  final String status;
  final String message;
  final AccountInEmployee account;

  DepositInEmployee({
    required this.depositId,
    required this.amount,
    required this.date,
    required this.status,
    required this.message,
    required this.account,
  });

  factory DepositInEmployee.fromJson(Map<String, dynamic> json) {
    return DepositInEmployee(
      depositId: json["depositId"],
      amount: (json["amount"] as num).toDouble(),
      date: DateTime.parse(json["date"]),
      status: json["status"],
      message: json["message"],
      account: AccountInEmployee .fromJson(json["account"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "depositId": depositId,
      "amount": amount,
      "date": date.toIso8601String(),
      "status": status,
      "message": message,
      "account": account.toJson(),
    };
  }
}
