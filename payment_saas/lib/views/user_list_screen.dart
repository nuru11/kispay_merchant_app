import 'package:flutter/material.dart';
import 'package:payment_saas/controllers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../controllers/user_provider.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final jj = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(jj.firstName.toString()),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => userProvider.fetchUsers(),
          ),
        ],
      ),
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : userProvider.users.isEmpty
              ? Center(child: Text("No users found"))
              : ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (context, index) {
                    final user = userProvider.users[index];
                    return ListTile(
                      title: Text(user.firstName),
                      subtitle: Text(user.email),
                      leading: CircleAvatar(child: Text(user.firstName[0])),
                    );
                  },
                ),
    );
  }
}
