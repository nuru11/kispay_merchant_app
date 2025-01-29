class UserModel {
  final String firstName;
  final String email;

  UserModel({required this.firstName, required this.email});

  // Factory constructor to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['name']['first'],
      email: json['email'],
    );
  }
}
