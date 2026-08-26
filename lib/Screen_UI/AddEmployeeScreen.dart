import 'package:employeeapp/Bloc/employee_bloc.dart';
import 'package:employeeapp/model/EmployeeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeScreen extends StatefulWidget {

  final EmployeeModel? employee;
  const AddEmployeeScreen({super.key,this.employee});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  final countryController = TextEditingController();

  @override
  void initState() {
    super.initState();


    if(widget.employee != null){

      nameController.text =
          widget.employee!.name;

      emailController.text =
          widget.employee!.email;

      mobileController.text =
          widget.employee!.mobile;

      countryController.text =
          widget.employee!.country;

    }

  }

  @override
  void dispose() {
    nameController.dispose();

    emailController.dispose();

    mobileController.dispose();

    countryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Add Employee"),

        backgroundColor: const Color(0xff2563EB),

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 45,

                backgroundColor: Color(0xffDBEAFE),

                child: Icon(
                  Icons.person_add,

                  size: 45,

                  color: Color(0xff2563EB),
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: nameController,

                decoration: inputDecoration("Employee Name", Icons.person),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter employee name";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: inputDecoration("Email", Icons.email),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }

                  if (!value.contains("@")) {
                    return "Invalid email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: mobileController,

                keyboardType: TextInputType.phone,

                decoration: inputDecoration("Mobile Number", Icons.phone),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter mobile number";
                  }

                  if (value.length != 10) {
                    return "Enter valid mobile number";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              TextFormField(
                controller: countryController,

                decoration: inputDecoration("Country", Icons.flag),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter country";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,

                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2563EB),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: () {

                    if (_formKey.currentState!.validate()) {


                      final employee = EmployeeModel(

                        // edit time pass the id
                        id: widget.employee?.id ?? "",

                        name: nameController.text.trim(),

                        email: emailController.text.trim(),

                        mobile: mobileController.text.trim(),

                        country: countryController.text.trim(),

                        state: widget.employee?.state ?? "",

                        district: widget.employee?.district ?? "",

                      );


                      if (widget.employee != null) {

                        // UPDATE (PUT API)
                        context.read<EmployeeBloc>().add(
                          UpdateEmployee(employee),
                        );


                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Employee Updated Successfully",
                            ),
                          ),
                        );


                      } else {

                        // ADD (POST API)
                        context.read<EmployeeBloc>().add(
                          AddEmployee(employee),
                        );


                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Employee Added Successfully",
                            ),
                          ),
                        );

                      }


                      Navigator.pop(context, true);

                    }

                  },

                  child: const Text(
                    "Save Employee",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String text, IconData icon) {
    return InputDecoration(
      labelText: text,

      prefixIcon: Icon(icon),

      filled: true,

      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),

        borderSide: BorderSide.none,
      ),
    );
  }
}
