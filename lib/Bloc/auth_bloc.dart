import 'package:bloc/bloc.dart';
import 'package:employeeapp/repository/auth_repository..dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginRequested>(_login);

    on<RegisterRequested>(_register);

    on<LogoutRequested>(_logout);
  }


  Future<void> _login(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      emit(AuthLoading());

      final user = await repository.login(
        event.email,
        event.password,
      );

      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Login failed"));
      }

    } on FirebaseAuthException catch (e) {

      print("Firebase Code: ${e.code}");
      print("Firebase Message: ${e.message}");

      switch (e.code) {

        case 'invalid-credential':
        case 'wrong-password':
          emit(AuthFailure("Invalid email or password"));
          break;

        case 'user-not-found':
          emit(AuthFailure("User not found"));
          break;

        case 'invalid-email':
          emit(AuthFailure("Invalid email address"));
          break;

        case 'user-disabled':
          emit(AuthFailure("User account is disabled"));
          break;

        case 'too-many-requests':
          emit(AuthFailure("Too many login attempts. Please try again later."));
          break;

        default:
          emit(AuthFailure("Unable to login. Please try again."));
          break;
      }

    } catch (e) {

      print(e);

      emit(AuthFailure("Something went wrong. Please try again."));
    }
  }
  Future<void> _register(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());

      final user = await repository.register(
        event.name,
        event.email,
        event.password,
      );

      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Registration failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _logout(LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await repository.logout();

      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
