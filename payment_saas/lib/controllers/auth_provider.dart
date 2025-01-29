import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:payment_saas/services/auth_service.dart';
import '../models/login_model.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _firstName;
  String? _lastName;
  bool _isLoading = false;
  String? _errorMessage;
  List<Map<String, dynamic>> _users = [];

  String? get token => _token;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get users => _users;

  final AuthService _authService = AuthService();

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      LoginResponse response = await _authService.login(email, password);
      _token = response.token;
      _firstName = response.firstName;
      _lastName = response.lastName;
      _isLoading = false;
      notifyListeners();

      await fetchUsers(); // Fetch users after successful login

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Login failed: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchUsers() async {
    if (_token == null) return;

    final url = Uri.parse("https://randomuser.me/api/?results=10"); // Fetch 10 users
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token", // Pass token if needed
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _users = List<Map<String, dynamic>>.from(data["results"]);
        notifyListeners();
      } else {
        _errorMessage = "Failed to fetch users";
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "Error: ${e.toString()}";
      notifyListeners();
    }
  }

  void logout() {
    _token = null;
    _firstName = null;
    _lastName = null;
    _users = [];
    notifyListeners();
  }
}
