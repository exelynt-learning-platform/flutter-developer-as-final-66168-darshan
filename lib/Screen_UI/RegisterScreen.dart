import 'package:employeeapp/Bloc/auth_bloc.dart';
import 'package:employeeapp/Screen_UI/EmployeeDashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Create Account"),

        backgroundColor: const Color(0xff2563EB),

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.person_add_alt_1,

                size: 80,

                color: Color(0xff2563EB),
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: nameController,

                decoration: inputDecoration("Full Name", Icons.person),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter name";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: emailController,

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

              const SizedBox(height: 16),

              TextFormField(
                controller: passwordController,

                obscureText: hidePassword,

                decoration: inputDecoration("Password", Icons.lock).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),

                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }

                  if (value.length < 6) {
                    return "Minimum 6 characters";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: confirmPasswordController,

                obscureText: true,

                decoration: inputDecoration(
                  "Confirm Password",
                  Icons.lock_outline,
                ),

                validator: (value) {
                  if (value != passwordController.text) {
                    return "Password not matched";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushReplacement(
                      context,

                      MaterialPageRoute(
                        builder: (_) => const EmployeeDashboardScreen(),
                      ),
                    );
                  }

                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },

                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2563EB),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  RegisterRequested(
                                    name: nameController.text.trim(),

                                    email: emailController.text.trim(),

                                    password: passwordController.text.trim(),
                                  ),
                                );
                              }
                            },

                      child: state is AuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Register",

                              style: TextStyle(
                                color: Colors.white,

                                fontSize: 17,
                              ),
                            ),
                    ),
                  );
                },
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
