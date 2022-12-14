import 'package:bloc_sign_in/auth/auth_cubit.dart';
import 'package:bloc_sign_in/auth/auth_repository.dart';
import 'package:bloc_sign_in/auth/form_submission_status.dart';
import 'package:bloc_sign_in/auth/sign_up/sign_up_bloc.dart';
import 'package:bloc_sign_in/auth/sign_up/sign_up_event.dart';
import 'package:bloc_sign_in/auth/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => SignUpBloc(
        authRepo: context.read<AuthRepository>(),
        authCubit: context.read<AuthCubit>(),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [_signUpForm(), _showLoginBottom(context)],
      ),
    ));
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameField(),
              _emailField(),
              _passwordField(),
              _signUpButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Username',
          ),
          validator: (value) =>
              state.isValidUsername ? null : 'Username is too short',
          onChanged: (value) => context.read<SignUpBloc>().add(
                SignUpUsernameChanged(username: value),
              ));
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpPasswordChanged(password: value)),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration:
            InputDecoration(icon: Icon(Icons.person), hintText: 'Email'),
        validator: (value) => state.isValidEmail ? null : 'Invalid emmail',
        onChanged: (value) =>
            context.read<SignUpBloc>().add(SignUpEmailChanged(email: value)),
      );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) => state.formStatus is FormSubmmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpBloc>().add(SignUpSubmmitted());
                }
              },
              child: Text('Sign up'),
            ),
    );
  }

  Widget _showLoginBottom(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: Text("Already have an account? Log in"),
        onPressed: () => context.read<AuthCubit>().showLogin(),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final _snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }
}
