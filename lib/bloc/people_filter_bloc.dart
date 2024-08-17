import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:training_app_for_weekend/bloc/people_filter_event.dart';
import 'package:training_app_for_weekend/bloc/people_filter_state.dart';
import 'package:training_app_for_weekend/models/user.dart';

class PeopleFilterBloc extends Bloc<PeopleFilterEvent, PeopleFilterState> {
  PeopleFilterBloc(this._users) : super(InitPeopleFilterState()) {
    _nameCtr.stream.listen((name) => add(NameChanged(name)));
    on<NameChanged>((event, emit) {
      _mapFilterUsersToState(emit);
    });

    _ageCtr.stream.listen((ages) => add(AgeChanged(ages)));
    on<AgeChanged>((event, emit) {
      _mapFilterUsersToState(emit);
    });

    on<AgeFilterChanged>((event, emit) {
      final currentAges = List<bool>.from(_ageCtr.value);
      currentAges[event.index] = event.isSelected;
      updateAge(currentAges);
      _mapFilterUsersToState(emit);
    });
  }

  final List<User> _users;
  final _nameCtr = BehaviorSubject<String>();
  final _ageCtr = BehaviorSubject<List<bool>>.seeded([
    false,
    false,
    false,
  ]);

  @override
  Future<void> close() {
    _nameCtr.close();
    _ageCtr.close();
    return super.close();
  }

  List<bool> get ageSelections => _ageCtr.value;

  void updateName(String name) {
    _nameCtr.add(name);
  }

  void updateAge(List<bool> ages) {
    _ageCtr.add(ages);
  }

  void _mapFilterUsersToState(Emitter<PeopleFilterState> emit) {
    final name = _nameCtr.value ?? '';
    final ages = _ageCtr.value;
    final selectedUsers = _users.where((user) {
      final matchesName = user.name.toLowerCase().contains(name.toLowerCase());
      final matchesAge = (ages[0] && user.age <= 5) ||
          (ages[1] && user.age >= 6 && user.age <= 10) ||
          (ages[2] && user.age > 10);
      return matchesName && matchesAge;
    }).toList();

    emit(LoadedPeople(selectedUsers));
  }
}
