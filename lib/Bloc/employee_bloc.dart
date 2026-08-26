import 'package:bloc/bloc.dart';
import 'package:employeeapp/model/EmployeeModel.dart';
import 'package:employeeapp/repository/EmployeeRepository.dart';
import 'package:meta/meta.dart';


part 'employee_event.dart';
part 'employee_state.dart';


class EmployeeBloc
    extends Bloc<EmployeeEvent, EmployeeState> {


  final EmployeeRepository repository;


  List<EmployeeModel> employees = [];


  EmployeeBloc(this.repository)
      : super(EmployeeInitial()) {


    on<LoadEmployees>(_loadEmployees);

    on<RefreshEmployees>(_loadEmployees);

    on<AddEmployee>(_addEmployee);

    on<UpdateEmployee>(_updateEmployee);

    on<DeleteEmployee>(_deleteEmployee);

    on<SearchEmployee>(_searchEmployee);

  }

  Future<void> _loadEmployees(
      EmployeeEvent event,
      Emitter<EmployeeState> emit) async {

    emit(EmployeeLoading());

    try {

      employees = await repository.getEmployees();


      // check API data
      for (var emp in employees) {
        print("ID: ${emp.id} Name: ${emp.name}");
      }


      emit(
        EmployeeLoaded(employees),
      );


    } catch(e) {

      print("Employee Error: $e");

      emit(
        EmployeeError(
          e.toString(),
        ),
      );

    }

  }



  Future<void> _addEmployee(
      AddEmployee event,
      Emitter<EmployeeState> emit) async {

    await repository.addEmployee(
        event.employee
    );

    add(
        LoadEmployees()
    );

  }



  Future<void> _updateEmployee(
      UpdateEmployee event,
      Emitter<EmployeeState> emit) async {

    await repository.updateEmployee(
        event.employee
    );

    add(
        LoadEmployees()
    );

  }



  Future<void> _deleteEmployee(
      DeleteEmployee event,
      Emitter<EmployeeState> emit) async {

    await repository.deleteEmployee(
        event.id
    );

    add(
        LoadEmployees()
    );

  }



  void _searchEmployee(
      SearchEmployee event,
      Emitter<EmployeeState> emit) {


    final result =
    employees.where((e) {

      return e.id
          .toLowerCase()
          .contains(
          event.query.toLowerCase()
      );

    }).toList();


    emit(
        EmployeeLoaded(result)
    );

  }

}