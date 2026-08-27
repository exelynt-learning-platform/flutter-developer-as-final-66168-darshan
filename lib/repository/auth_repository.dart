import 'package:firebase_auth/firebase_auth.dart';
import 'package:employeeapp/services/auth_service.dart';


class AuthRepository {

  final AuthService service;


  AuthRepository(this.service);



  Future<User?> login(
      String email,
      String password,
      ) async {

    return await service.login(
      email,
      password,
    );

  }



  Future<User?> register(
      String name,
      String email,
      String password,
      ) async {

    return await service.register(
      name,
      email,
      password,
    );

  }



  Future<void> logout() async {

    await service.logout();

  }



  User? get currentUser {

    return service.currentUser;

  }



  Stream<User?> authStateChanges() {

    return service.authStateChanges;

  }

}