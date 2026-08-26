class ApiConstants {

  static const String baseUrl =
      "https://669b3f09276e45187d34eb4e.mockapi.io/api/v1";


  // Employee APIs
  static const String employees =
      "$baseUrl/employee";


  // Country API
  static const String countries =
      "$baseUrl/country";


  static String employeeById(String id) {
    return "$employees/$id";
  }

}