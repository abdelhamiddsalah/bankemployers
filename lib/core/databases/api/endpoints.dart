import 'dart:io';

class Endpoints {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8080/api/"; // Emulator
    } else {
      return "http://localhost:8080/api/"; // Windows / macOS
    }
  }

  static const String signupAdmin = "registerAdmin";
  static const String signupEmployee = "employee/signup";
  static const String uploadCv = "upload-cv";
  static const String allEmployers = "admin/allEmployers";
  static String deleteEmployer(String id) => "admin/employer/$id";
  static String searchEmployers(String query) => "admin/searchEmployers/query=$query";
  static String getEmployerById(String id) => "admin/getEmployer/$id";
  static const String allUsers = "admin/allUsers";
  static String deleteUser(String id) => "admin/user/$id";
  static String getCvById(int id) => "admin/Cv/$id";
}
