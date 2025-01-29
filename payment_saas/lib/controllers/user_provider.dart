import 'package:flutter/material.dart';
import 'package:payment_saas/services/api_services.dart';
import '../models/user_model.dart';
// import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];
  bool _isLoading = false;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  // Fetch users and update state
  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _apiService.fetchUsers();
    } catch (e) {
      print("Error fetching users: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
