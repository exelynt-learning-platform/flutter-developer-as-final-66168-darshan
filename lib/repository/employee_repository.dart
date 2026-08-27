import 'package:employeeapp/model/country_model.dart';
import 'package:employeeapp/model/employee_model.dart';
import 'package:employeeapp/services/employee_service.dart';



class EmployeeRepository {

  final EmployeeService services;

  EmployeeRepository(this.services);


  Future<List<EmployeeModel>> getEmployees() async {

    final response = await services.getEmployees();

    return (response.data as List)
        .map((e) => EmployeeModel.fromJson(e))
        .toList();

  }


  Future<EmployeeModel> getEmployeeById(String id) async {

    final response = await services.getEmployeeById(id);

    return EmployeeModel.fromJson(response.data);

  }


  Future<EmployeeModel> addEmployee(
      EmployeeModel employee) async {

    final response =
    await services.addEmployee(employee.toJson());

    return EmployeeModel.fromJson(response.data);

  }


  Future<EmployeeModel> updateEmployee(
      EmployeeModel employee) async {

    final response =
    await services.updateEmployee(
      employee.id,
      employee.toJson(),
    );

    return EmployeeModel.fromJson(response.data);

  }


  Future<void> deleteEmployee(String id) async {

    await services.deleteEmployee(id);

  }


  Future<List<CountryModel>> getCountries() async {

    final response = await services.getCountries();

    return (response.data as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();

  }

}
