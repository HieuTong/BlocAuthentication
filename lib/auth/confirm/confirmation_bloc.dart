import 'package:bloc_sign_in/auth/auth_cubit.dart';
import 'package:bloc_sign_in/auth/confirm/confirmation_event.dart';
import 'package:bloc_sign_in/auth/confirm/confirmation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_repository.dart';
import '../form_submission_status.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({required this.authRepo, required this.authCubit})
      : super(ConfirmationState()) {
    on((event, emit) async {
      if (event is ConfirmationCodeChanged) {
        emit(state.copyWith(code: event.code));
      } else if (event is ConfirmationSubmitted) {
        emit(state.copyWith(formStatus: FormSubmmitting()));
        try {
          final userId = await authRepo.confirmSignUp(
              username: authCubit.credentials.username,
              confirmationCode: state.code);
          emit(state.copyWith(formStatus: SubmissionSuccess()));

          final credentials = authCubit.credentials;
          credentials.userId = userId;

          authCubit.launchSession(credentials);
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(e)));
        }
      }
    });
  }
}
