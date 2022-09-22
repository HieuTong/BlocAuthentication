import 'package:bloc_sign_in/auth/auth_cubit.dart';
import 'package:bloc_sign_in/auth/auth_repository.dart';
import 'package:bloc_sign_in/auth/form_submission_status.dart';
import 'package:bloc_sign_in/auth/login/login_event.dart';
import 'package:bloc_sign_in/auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_up/auth_credentials.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})
      : super(LoginState()) {
    on((event, emit) async {
      if (event is LoginUsernameChanged) {
        emit(state.copyWith(username: event.username));
      } else if (event is LoginPasswordChanged) {
        emit(state.copyWith(password: event.password));
      } else if (event is LoginSubmitted) {
        emit(state.copyWith(formStatus: FormSubmmitting()));

        try {
          final userId = await authRepo.login(
              username: state.username, password: state.password);
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          authCubit.launchSession(AuthCredentials(
            username: state.username,
            userId: userId,
          ));
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(e)));
        }
      }
    });
  }
}
