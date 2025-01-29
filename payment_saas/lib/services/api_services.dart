import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:payment_saas/models/login_model.dart';
import '../models/user_model.dart';

class ApiService {
  static const String apiUrl = "https://randomuser.me/api/?results=10";

    // static const String loginUrl = "https://api.kispay.et/api/auth/login";


  // Fetch users from API
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      // Convert JSON response to a List of UserModel
      return results.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }


  //  Future<LoginResponse> login(String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse(loginUrl),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({'email': email, 'password': password}),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return LoginResponse.fromJson(data);
  //   } else {
  //     throw Exception("Login failed: ${response.body}");
  //   }
  // }
}
