import 'package:employeeapp/screens/splash_screen.dart';
import 'package:employeeapp/services/employee_service.dart';
import 'package:employeeapp/repository/employee_repository.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/employee_bloc.dart';

import 'services/auth_service.dart';
import 'repository/auth_repository.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(

    MultiBlocProvider(

      providers: [

        BlocProvider<AuthBloc>(
          create: (_) =>
              AuthBloc(
                AuthRepository(
                  AuthService(),
                ),
              ),
        ),


        BlocProvider<EmployeeBloc>(
          create: (_) =>
              EmployeeBloc(
                EmployeeRepository(
                  EmployeeService(
                    Dio(),
                  ),
                ),
              ),
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
