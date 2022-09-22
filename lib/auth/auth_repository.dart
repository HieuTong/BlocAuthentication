import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  Future<String> attempAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('not signed in');
  }

  Future<String> login({
    required String username,
    required String password,
  }) async {
    print('attemping login');
    await Future.delayed(Duration(seconds: 3));
    return 'abc';
  }

  Future<void> signUp(
      {required String username,
      required String email,
      required String password}) async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<String> confirmSignUp({
    required String username,
    required String confirmationCode,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return 'abc';
  }

  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
