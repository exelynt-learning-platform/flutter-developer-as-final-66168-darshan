import 'package:employeeapp/Screen_UI/SplashScreen.dart';
import 'package:employeeapp/Service/EmployeeService.dart';
import 'package:employeeapp/repository/EmployeeRepository.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'Bloc/auth_bloc.dart';
import 'Bloc/employee_bloc.dart';

import 'Service/AuthService.dart';
import 'repository/auth_repository..dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        // Auth Bloc
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(AuthRepository(AuthService())),
        ),

        // Employee Bloc
        BlocProvider<EmployeeBloc>(
          create: (_) =>
              EmployeeBloc(EmployeeRepository(EmployeeService(Dio()))),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const SplashScreen(),
    );
  }
}
