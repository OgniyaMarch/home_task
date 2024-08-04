import 'package:flutter/material.dart';
import 'package:training_app_for_weekend/isar_service.dart';
import 'package:training_app_for_weekend/models/user.dart';

class Screen extends StatefulWidget {
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                await IsarService().addUsers();
              },
              child: Text('Add 1000 users'),
            ),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: IsarService().getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No users found.'));
                  } else {
                    List<User>? users = snapshot.data;
                    return ListView.builder(
                      itemCount: users?.length,
                      itemBuilder: (context, index) {
                        User? user = users?[index];
                        return ListTile(
                          title: Text(user?.name ?? 'empty name'),
                          subtitle: Text('Age: ${user?.age}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
