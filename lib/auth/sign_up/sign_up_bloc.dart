import 'package:bloc_sign_in/auth/auth_cubit.dart';
import 'package:bloc_sign_in/auth/auth_repository.dart';
import 'package:bloc_sign_in/auth/form_submission_status.dart';
import 'package:bloc_sign_in/auth/login/login_event.dart';
import 'package:bloc_sign_in/auth/login/login_state.dart';
import 'package:bloc_sign_in/auth/sign_up/sign_up_event.dart';
import 'package:bloc_sign_in/auth/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(SignUpState()) {
    on((event, emit) async {
      if (event is SignUpUsernameChanged) {
        emit(state.copyWith(username: event.username));
      } else if (event is SignUpEmailChanged) {
        emit(state.copyWith(email: event.email));
      } else if (event is SignUpPasswordChanged) {
        emit(state.copyWith(formStatus: FormSubmmitting()));
        try {
          await authRepo.signUp(
              username: state.username,
              email: state.email,
              password: state.password);
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          authCubit.showConfirmSignUp(
              username: state.username,
              email: state.email,
              password: state.password);
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(e)));
        }
      }
    });
  }
}
