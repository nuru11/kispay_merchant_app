class LoginResponse {
  final String token;
  final String firstName;
  final String lastName;

  LoginResponse({
    required this.token,
    required this.firstName,
    required this.lastName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("body") && json["body"].containsKey("token") && json["body"].containsKey("user")) {
      return LoginResponse(
        token: json["body"]["token"],
        firstName: json["body"]["user"]["firstName"],
        lastName: json["body"]["user"]["lastName"],
      );
    } else {
      throw Exception("Invalid API response: Token or User Data not found");
    }
  }
}
