import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/login_model.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _firstName;
  String? _lastName;
  bool _isLoading = false;
  String? _errorMessage;

  String? get token => _token;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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
      print("User: $_firstName $_lastName"); // Debugging
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      notifyListeners();
      return false;
    }
  }
}
