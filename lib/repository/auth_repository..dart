import 'package:employeeapp/Service/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<User?> login(String email, String password) async {
    return await authService.login(email, password);
  }

  Future<User?> register(
      String name,
      String email,
      String password,
      ) async {

    return await authService.register(
      name,
      email,
      password,
    );

  }

  Future<void> logout() async {
    await authService.logout();
  }

  User? get currentUser {
    return authService.currentUser;
  }

  Stream<User?> authStateChanges() {
    return authService.authStateChanges;
  }
}
