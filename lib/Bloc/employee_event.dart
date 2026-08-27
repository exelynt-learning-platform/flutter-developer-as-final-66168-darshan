part of 'employee_bloc.dart';


@immutable
sealed class EmployeeEvent {}


class LoadEmployees extends EmployeeEvent {}


class AddEmployee extends EmployeeEvent {

  final EmployeeModel employee;

  AddEmployee(this.employee);

}


class UpdateEmployee extends EmployeeEvent {

  final EmployeeModel employee;

  UpdateEmployee(this.employee);

}


class DeleteEmployee extends EmployeeEvent {

  final String id;

  DeleteEmployee(this.id);

}


class SearchEmployee extends EmployeeEvent {

  final String query;

  SearchEmployee(this.query);

}


class RefreshEmployees extends EmployeeEvent {}