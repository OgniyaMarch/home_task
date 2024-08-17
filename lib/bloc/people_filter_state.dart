import 'package:training_app_for_weekend/models/user.dart';

abstract class PeopleFilterState {}

class InitPeopleFilterState extends PeopleFilterState {}

class LoadedPeople extends PeopleFilterState {
  LoadedPeople(this.selectedUsers);

  List<User> selectedUsers;
}
