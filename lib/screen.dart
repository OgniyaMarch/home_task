import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app_for_weekend/bloc/people_filter_bloc.dart';
import 'package:training_app_for_weekend/bloc/people_filter_state.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People Filter'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Enter name'),
            onChanged: (value) =>
                context.read<PeopleFilterBloc>().updateName(value),
          ),
          Row(
            children: [
              Checkbox(
                value: _getAgeValue(0),
                onChanged: (value) => _changeAge(value, 0),
              ),
              const Text('1-5'),
              Checkbox(
                value: _getAgeValue(1),
                onChanged: (value) => _changeAge(value, 1),
              ),
              const Text('6-10'),
              Checkbox(
                  value: _getAgeValue(2),
                  onChanged: (value) => _changeAge(value, 2)),
              const Text('10+'),
            ],
          ),
          Expanded(
            child: BlocBuilder<PeopleFilterBloc, PeopleFilterState>(
              builder: (context, state) {
                if (state is LoadedPeople) {
                  return ListView.builder(
                    itemCount: state.selectedUsers.length,
                    itemBuilder: (context, index) {
                      final user = state.selectedUsers[index];
                      return ListTile(
                        title: Text('${user.name}, Age: ${user.age}'),
                      );
                    },
                  );
                }
                return const Center(child: Text('No users found.'));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _changeAge(bool? value, int index) {
    final currentAges =
        List<bool>.from(context.read<PeopleFilterBloc>().ageSelections);
    currentAges[index] = value ?? false;
    context.read<PeopleFilterBloc>().updateAge(currentAges);
  }

  bool _getAgeValue(int index) {
    return context
        .select<PeopleFilterBloc, bool>((bloc) => bloc.ageSelections[index]);
  }
}
