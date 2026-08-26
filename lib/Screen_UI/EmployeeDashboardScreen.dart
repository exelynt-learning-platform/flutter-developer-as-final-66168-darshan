import 'package:employeeapp/Bloc/employee_bloc.dart';
import 'package:employeeapp/Screen_UI/AddEmployeeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_screen.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<EmployeeBloc>().add(LoadEmployees());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        elevation: 0,

        backgroundColor: const Color(0xff2563EB),

        title: const Text("Employee Dashboard"),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,

                MaterialPageRoute(builder: (_) => const LoginScreen()),

                (route) => false,
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff2563EB),

        icon: const Icon(Icons.add, color: Colors.white),

        label: const Text(
          "Add Employee",

          style: TextStyle(color: Colors.white),
        ),

        onPressed: () async {
          await Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: context.read<EmployeeBloc>(),

                child: const AddEmployeeScreen(),
              ),
            ),
          );

          context.read<EmployeeBloc>().add(LoadEmployees());
        },
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          context.read<EmployeeBloc>().add(RefreshEmployees());
        },

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              BlocBuilder<EmployeeBloc, EmployeeState>(
                builder: (context, state) {
                  int count = 0;

                  if (state is EmployeeLoaded) {
                    count = state.employees.length;
                  }

                  return Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: const Color(0xff2563EB),

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Row(
                      children: [
                        const Icon(Icons.people, size: 50, color: Colors.white),

                        const SizedBox(width: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              "Total Employees",

                              style: TextStyle(color: Colors.white70),
                            ),

                            Text(
                              count.toString(),

                              style: const TextStyle(
                                color: Colors.white,

                                fontSize: 30,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              TextField(
                controller: searchController,

                decoration: InputDecoration(
                  hintText: "Search employee by ID",

                  prefixIcon: const Icon(Icons.search),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),

                    borderSide: BorderSide.none,
                  ),
                ),

                onChanged: (value) {
                  context.read<EmployeeBloc>().add(SearchEmployee(value));
                },
              ),

              const SizedBox(height: 20),

              const Text(
                "Employees",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                    if (state is EmployeeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is EmployeeError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is EmployeeLoaded) {
                      if (state.employees.isEmpty) {
                        return const Center(child: Text("No Employee Found"));
                      }

                      return ListView.builder(
                        itemCount: state.employees.length,

                        itemBuilder: (context, index) {
                          final emp = state.employees[index];

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),

                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xffDBEAFE),

                                child: Text(
                                  emp.name[0],

                                  style: const TextStyle(
                                    color: Color(0xff2563EB),
                                  ),
                                ),
                              ),

                              title: Text(emp.name),

                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(emp.email),

                                  Text(emp.mobile),

                                  Text(emp.country),
                                ],
                              ),

                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),

                                    onPressed: () async {

                                      await Navigator.push(
                                        context,

                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: context.read<EmployeeBloc>(),

                                            child: AddEmployeeScreen(
                                              employee: emp,
                                            ),
                                          ),
                                        ),
                                      );

                                      context.read<EmployeeBloc>().add(
                                        LoadEmployees(),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),

                                    onPressed: () {

                                      context.read<EmployeeBloc>().add(
                                        DeleteEmployee(
                                          emp.id,
                                        ),
                                      );

                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
