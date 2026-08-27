import 'package:dio/dio.dart';
import 'package:employeeapp/core/api_constants.dart';



class EmployeeService {

  final Dio dio;

  EmployeeService(this.dio);


  // Get All Employees
  Future<Response> getEmployees() async {

    return await dio.get(
      ApiConstants.employees,
    );

  }


  // Get Employee By Id
  Future<Response> getEmployeeById(String id) async {

    return await dio.get(
      ApiConstants.employeeById(id),
    );

  }


  // Add Employee
  Future<Response> addEmployee(
      Map<String, dynamic> data) async {

    return await dio.post(
      ApiConstants.employees,
      data: data,
    );

  }


  // Update Employee
  Future<Response> updateEmployee(
      String id,
      Map<String, dynamic> data) async {

    return await dio.put(
      ApiConstants.employeeById(id),
      data: data,
    );

  }


  // Delete Employee
  Future<Response> deleteEmployee(String id) async {

    return await dio.delete(
      ApiConstants.employeeById(id),
    );

  }


  // Get Countries
  Future<Response> getCountries() async {

    return await dio.get(
      ApiConstants.countries,
    );

  }

}
