import 'package:flutter/material.dart';
import 'package:training_app_for_weekend/bloc/people_filter_bloc.dart';
import 'package:training_app_for_weekend/models/user.dart';
import 'package:training_app_for_weekend/screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<User> users = User.generateUsers(1000);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PeopleFilterBloc>(
      create: (BuildContext context) => PeopleFilterBloc(users),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Screen(),
      ),
    );
  }
}
