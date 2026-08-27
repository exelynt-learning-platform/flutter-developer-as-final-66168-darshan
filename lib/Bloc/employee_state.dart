part of 'employee_bloc.dart';


@immutable
sealed class EmployeeState {}


class EmployeeInitial extends EmployeeState {}


class EmployeeLoading extends EmployeeState {}


class EmployeeLoaded extends EmployeeState {

  final List<EmployeeModel> employees;

  EmployeeLoaded(this.employees);

}


class EmployeeError extends EmployeeState {

  final String message;

  EmployeeError(this.message);

}