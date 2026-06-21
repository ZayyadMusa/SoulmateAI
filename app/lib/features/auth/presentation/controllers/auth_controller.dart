import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  bool build() {
    return false; // false = not logged in, true = logged in
  }

  Future<void> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (email.isNotEmpty && password.isNotEmpty) {
      state = true;
    } else {
      throw Exception('Email and password cannot be empty');
    }
  }

  Future<void> signUp(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (email.isNotEmpty && password.length >= 6) {
      state = true;
    } else {
      throw Exception('Password must be at least 6 characters');
    }
  }

  Future<void> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    // Assume success for mock
  }

  void logout() {
    state = false;
  }
}
