import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_provider.dart';
import 'login_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch users when the screen loads
    Future.delayed(Duration.zero, () {
      Provider.of<AuthProvider>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        authProvider.logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: Text("Logout"),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            color: Colors.blueAccent,
            child: Text(
              "Welcome, ${authProvider.firstName ?? ''} ${authProvider.lastName ?? ''}!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: authProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : authProvider.errorMessage != null
                    ? Center(child: Text(authProvider.errorMessage!))
                    : authProvider.users.isEmpty
                        ? Center(child: Text("No users found"))
                        : ListView.builder(
                            itemCount: authProvider.users.length,
                            itemBuilder: (context, index) {
                              final user = authProvider.users[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(user["picture"]["thumbnail"]),
                                ),
                                title: Text("${user["name"]["first"]} ${user["name"]["last"]}"),
                                subtitle: Text(user["email"]),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
