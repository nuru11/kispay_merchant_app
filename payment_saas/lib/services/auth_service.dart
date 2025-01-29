import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';

class AuthService {
  static const String loginUrl = "https://api.kispay.et/api/auth/login";

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data.containsKey("body")) {
        return LoginResponse.fromJson(data);
      } else {
        throw Exception(data["message"] ?? "Login failed");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
