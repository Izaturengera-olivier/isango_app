import 'dart:async';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Simulate user database
  final Map<String, String> _users = {};

  Future<bool> login(String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Check if user exists and password matches (in real app, this would be server-side)
    if (_users.containsKey(email) && _users[email] == password) {
      return true;
    }
    return false;
  }

  Future<bool> signup(String name, String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Check if email already exists
    if (_users.containsKey(email)) {
      return false;
    }
    
    // Register new user (in real app, this would be server-side)
    _users[email] = password;
    return true;
  }

  Future<bool> validateEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<bool> validatePassword(String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return password.length >= 6;
  }

  Future<bool> validateName(String name) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return name.trim().length >= 2;
  }
}
