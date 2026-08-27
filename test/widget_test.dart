import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dio/dio.dart';

import 'package:employeeapp/main.dart';
import 'package:employeeapp/Bloc/auth_bloc.dart';
import 'package:employeeapp/Bloc/employee_bloc.dart';
import 'package:employeeapp/Service/AuthService.dart';
import 'package:employeeapp/Service/EmployeeService.dart';
import 'package:employeeapp/repository/auth_repository..dart';
import 'package:employeeapp/repository/EmployeeRepository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    const MethodChannel channel =
    MethodChannel('plugins.flutter.io/firebase_core');

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'Firebase#initializeCore') {
        return [
          {
            'name': '[DEFAULT]',
            'options': {
              'apiKey': 'fake-api-key',
              'appId': 'fake-app-id',
              'messagingSenderId': 'fake-sender-id',
              'projectId': 'fake-project-id',
            },
            'pluginConstants': {},
          }
        ];
      }
      if (methodCall.method == 'Firebase#initializeApp') {
        return {
          'name': methodCall.arguments['appName'],
          'options': methodCall.arguments['options'],
          'pluginConstants': {},
        };
      }
      return null;
    });

    await Firebase.initializeApp();
  });

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