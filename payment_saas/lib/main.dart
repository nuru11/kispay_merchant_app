import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_provider.dart';
import 'controllers/user_provider.dart';
import 'views/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: LoginScreen(),
    );
  }
}
