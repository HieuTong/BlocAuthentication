import 'package:bloc_sign_in/auth/sign_up/auth_credentials.dart';
import 'package:bloc_sign_in/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState { login, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  late AuthCredentials credentials;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showConfirmSignUp({
    required String username,
    required String email,
    required String password,
  }) {
    credentials =
        AuthCredentials(username: username, email: email, password: password);
    emit(AuthState.confirmSignUp);
  }

  void launchSession(AuthCredentials credentials) {
    sessionCubit.showSession(credentials);
  }
}
