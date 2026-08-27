import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:employeeapp/main.dart';
import 'package:employeeapp/Bloc/auth_bloc.dart';
import 'package:employeeapp/Bloc/employee_bloc.dart';
import 'package:employeeapp/Service/AuthService.dart';
import 'package:employeeapp/Service/EmployeeService.dart';
import 'package:employeeapp/repository/auth_repository..dart';
import 'package:employeeapp/repository/EmployeeRepository.dart';

void main() {
  testWidgets('Employee Management App loads successfully',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (_) => AuthBloc(AuthRepository(AuthService())),
              ),
              BlocProvider<EmployeeBloc>(
                create: (_) =>
                    EmployeeBloc(EmployeeRepository(EmployeeService(Dio()))),
              ),
            ],
            child: const MyApp(),
          ),
        );

        await tester.pump(const Duration(seconds: 3));

        expect(find.byType(MyApp), findsOneWidget);
      });
}