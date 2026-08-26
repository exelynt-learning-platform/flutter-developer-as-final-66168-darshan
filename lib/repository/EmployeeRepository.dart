import 'package:employeeapp/model/CountryModel.dart';
import 'package:employeeapp/model/EmployeeModel.dart';

import '../Service/EmployeeService.dart';



class EmployeeRepository {

  final EmployeeService service;

  EmployeeRepository(this.service);


  Future<List<EmployeeModel>> getEmployees() async {

    final response = await service.getEmployees();

    return (response.data as List)
        .map((e) => EmployeeModel.fromJson(e))
        .toList();

  }


  Future<EmployeeModel> getEmployeeById(String id) async {

    final response = await service.getEmployeeById(id);

    return EmployeeModel.fromJson(response.data);

  }


  Future<EmployeeModel> addEmployee(
      EmployeeModel employee) async {

    final response =
    await service.addEmployee(employee.toJson());

    return EmployeeModel.fromJson(response.data);

  }


  Future<EmployeeModel> updateEmployee(
      EmployeeModel employee) async {

    final response =
    await service.updateEmployee(
      employee.id,
      employee.toJson(),
    );

    return EmployeeModel.fromJson(response.data);

  }


  Future<void> deleteEmployee(String id) async {

    await service.deleteEmployee(id);

  }


  Future<List<CountryModel>> getCountries() async {

    final response = await service.getCountries();

    return (response.data as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();

  }

}