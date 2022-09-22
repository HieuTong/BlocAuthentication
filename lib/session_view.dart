import 'package:bloc_sign_in/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionView extends StatelessWidget {
  const SessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Session View'),
            TextButton(
                child: Text('sign out'),
                onPressed: () =>
                    BlocProvider.of<SessionCubit>(context).signOut())
          ],
        ),
      ),
    );
  }
}
